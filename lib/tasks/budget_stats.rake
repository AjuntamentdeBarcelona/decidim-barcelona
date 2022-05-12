# frozen_string_literal: true

namespace :budgets do
  desc "Get stats for budgets in a component"
  task :stats, [:component_id] => :environment do |_task, args|
    # Handlers where to find gender and 

    component = Decidim::Component.find_by(id: args.component_id)
    abort("Please specify a component id") unless component

    budgets = Decidim::Budgets::Budget.where(component: component)
    budgets.find_each do |budget|
      puts "BUDGET ##{budget.id} - #{budget.title.values.first}"
      orders = orders_for(budget)
      puts "Finished orders: #{orders[:finished_orders].count}"
      puts "   Unique users: #{orders[:finished_users].count}"
      puts "Pending orders:  #{orders[:pending_orders].count}"
      puts "   Unique users: #{orders[:pending_users].count}"

      pending = stats_for(orders[:finished_users])
      puts "Gender stats:"
      puts "   #{pending[:gender]}"
      puts "Age stats:"
      puts "   #{pending[:age]}"
    end
  end

  def orders_for(budget)
    orders = Decidim::Budgets::Order.where(budget: budget)
    { 
      orders: orders,
      finished_orders: orders.finished,
      pending_orders: orders.pending,
      users: Decidim::User.where(id: orders.pluck(:decidim_user_id)),
      finished_users: Decidim::User.where(id: orders.finished.pluck(:decidim_user_id)).distinct,
      pending_users: Decidim::User.where(id: orders.pending.pluck(:decidim_user_id)).distinct
    }
  end

  def stats_for(users)
    handlers = [:census_sms_authorization_handler, :census_authorization_handler]
    gender_stats = Hash.new(0)
    age_stats = Hash.new(0)
    total = users.count
    begin
      users.find_each.with_index do |user, index|
        print "\rDecoding user #{index + 1} of #{total} - #{(100 * index.to_f / total.to_f).round(2)}%"
        authorizations = Decidim::Authorization.where(name: handlers, user: user).to_a
        gender = authorizations.find {|m| m.metadata.dig("extras","gender") }
        gender_stats[gender] += 1 
        age = authorizations.find {|m| m.metadata.dig("date_of_birth") }.try(:metadata)
        age = begin
          5 * ((Date.today.year - Date.parse(age["date_of_birth"]).year)/5).round
        rescue
          0
        end
        age_stats[age] += 1 

        # break if index > 10
      end
      print "\n"
    rescue Interrupt
      puts "\n--- Program interrupted, printing partial stats ---"
    end
    { gender: gender_stats, age: age_stats }
  end
end
