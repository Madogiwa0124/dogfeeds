module AuthenticationHelper
  def visit_with_basic_login(path)
    basic_auth_config = Rails.configuration.settings.basic_auth
    user = basic_auth_config[:user]
    pw = basic_auth_config[:password]
    host = Capybara.current_session.server.host
    port = Capybara.current_session.server.port
    visit "http://#{user}:#{pw}@#{host}:#{port}#{path}"
  end
end
