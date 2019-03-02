class Admin::ApplicationController < ApplicationController
  before_action :basic_auth
  layout 'admin/application'

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |user, password|
      user == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
