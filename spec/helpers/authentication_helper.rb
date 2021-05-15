module AuthenticationHelper
  def visit_with_basic_login(path)
    user = ENV['BASIC_AUTH_USER']
    pw = ENV['BASIC_AUTH_PASSWORD']
    host = Capybara.current_session.server.host
    port = Capybara.current_session.server.port
    visit "http://#{user}:#{pw}@#{host}:#{port}#{path}"
  end
end
