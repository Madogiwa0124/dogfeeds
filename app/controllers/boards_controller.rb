class BoardsController < ApplicationController
  def index; end

  def new; end

  def show
    @board_id = params[:id]
  end
end
