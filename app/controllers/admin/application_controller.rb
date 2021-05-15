class Admin::ApplicationController < ApplicationController
  before_action :basic_auth
  layout 'admin/application'

  private

  def basic_auth
    basic_auth_config = Rails.configuration.settings.basic_auth
    authenticate_or_request_with_http_basic do |user, password|
      user == basic_auth_config[:user] && password == basic_auth_config[:password]
    end
  end
end
