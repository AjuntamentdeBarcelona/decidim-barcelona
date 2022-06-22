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
      pending[:gender].sort_by { |k, _v| k.to_s }.each do |key, val|
        puts "   #{if key.nil?
                     "unknown"
                   else
                     (key.presence || :empty)
                   end}: #{val}"
      end
      puts "Age stats:"
      pending[:age].sort_by { |k, _v| k.to_i }.each do |key, val|
        num = "#{key}-#{key.to_i + 4}"
        puts "   #{key.blank? ? "unknown" : num}: #{val}"
      end
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
        print "\rDecoding user #{index + 1} of #{total} - #{(100 * (1 + index.to_f) / total.to_f).round(2)}%"
        gender = nil
        age = nil
        handlers.each do |handler|
          metadata = Decidim::Authorization.find_by(name: handler, user: user).try(:metadata)
          next unless metadata

          gender = metadata.dig("extras", "gender") if gender.nil?
          age = metadata["date_of_birth"] if age.nil?
        end
        gender_stats[gender] += 1
        age = begin
          5 * ((Time.zone.today.year - Date.parse(age).year) / 5).round
        rescue StandardError
          nil
        end
        age_stats[age] += 1
      end
      print "\n"
    rescue Interrupt
      puts "\n--- Program interrupted, printing partial stats ---"
    end
    { gender: gender_stats, age: age_stats }
  end
end
