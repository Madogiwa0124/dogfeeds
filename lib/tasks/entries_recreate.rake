namespace :entries do
  desc 'It is a task to re-acquire the latest articles related to all Feeds'
  task recreate: :environment do
    Feed.all.each do |feed|
      sleep 1
      ActiveRecord::Base.transaction { Feed::EntryCreater.new(feed).execute! }
    rescue => e
      raised_error = e.exception("#{e.message} raised from endpoint: #{feed.endpoint}")
      Rails.logger.error(raised_error)
      Rollbar.error(raised_error)
      next
    end
  end
end
