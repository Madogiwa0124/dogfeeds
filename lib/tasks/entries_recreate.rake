namespace :entries do
  desc 'It is a task to re-acquire the latest articles related to all Feeds'
  task recreate: :environment do
    Feed.all.each do |feed|
      ActiveRecord::Base.transaction { Feed::EntryCreater.new(feed).execute! }
    end
  end
end
