namespace :entries do
  desc 'It is a task to re-acquire the latest articles related to all Feeds'
  task recreate: :environment do
    Feed.all.each do |feed|
      sleep 1
      ActiveRecord::Base.transaction { Feed::EntryCreater.new(feed).execute! }
    rescue => e
      Rails.logger.error(e)
      Rollbar.error(e, endpoint: feed.endpoint)
      next
    end
  end
end
