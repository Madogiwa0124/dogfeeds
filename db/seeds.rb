# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "=== START ==="

puts "=== delete old data ==="
ActiveRecord::Base.transaction {
  Entry.delete_all
  Feed.delete_all
}

puts "=== create feeds ==="
# TODO: set your test site to endpoint
# FactoryBot.create_list(:feed, 10, endpoint: 'rss end points')

puts "=== create entries ==="
Feed.all.each do |feed|
  sleep 1
  ActiveRecord::Base.transaction { Feed::EntryCreater.new(feed).execute! }
rescue => e
  Rails.logger.error(e)
  next
end

puts "=== FINISHED ==="
