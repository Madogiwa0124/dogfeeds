# frozen_string_literal: true

OkComputer::OkComputerController.class_eval do
  self.view_paths = 'lib/okcomputer/app/views'

  def respond(data, status)
    respond_to do |format|
      format.text { render plain: data, status: status, content_type: 'text/plain' }
      format.html { render "/#{action_name}", locals: { data: data, status: status }, content_type: 'text/html' }
      format.json { render json: data, status: status }
    end
  end
end
