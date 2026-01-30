# frozen_string_literal: true

namespace :notifications do
  desc "Destroy old notifications"
  task :destroy_old, [:to, :from] => :environment do |_task, args|
    args.with_defaults(
      to: 1.year.ago.strftime("%Y-%m-%d"),
      from: "2017-01-01"
    )

    current_date = Date.parse(args.from).beginning_of_month
    end_date = Date.parse(args.to).beginning_of_month
    dates = []
    while current_date <= end_date
      dates << current_date.strftime("%Y-%m-%d")
      current_date = current_date.next_month
    end

    total = 0
    dates.each do |date|
      notifications = Decidim::Notification.where(created_at: ...date)
      total += notifications.count
      puts "Destroying #{notifications.count} notifications older than #{date}..."
      notifications.destroy_all
    end

    puts "You have successfully destroyed #{total} notifications."
  end
end
