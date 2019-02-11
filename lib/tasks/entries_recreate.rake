namespace :entries do
  desc 'It is a task to re-acquire the latest articles related to all Feeds'
  task :recreate do
    Feed.all.each { |feed| Feed::EntryCreater.new(feed).execute }
  end
end
