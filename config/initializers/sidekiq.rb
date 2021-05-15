require 'sidekiq/web'

# NOTE: sidekiqのwebuiにベーシック認証をかける
basic_auth_config = Rails.configuration.settings.basic_auth
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [basic_auth_config[:user], basic_auth_config[:password]]
end
