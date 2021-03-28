require 'sidekiq/web'

# NOTE: sidekiqのwebuiにベーシック認証をかける
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['BASIC_AUTH_USER'], ENV['BASIC_AUTH_PASSWORD']]
end
