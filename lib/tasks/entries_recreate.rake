namespace :entries do
  desc 'It is a task to re-acquire the latest articles related to all Feeds'
  task recreate: :environment do
    Feed.find_each do |feed|
      sleep 1
      EntriesRecreateJob.perform_later(feed)
    end
  end
end
