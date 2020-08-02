class BoardsController < ApplicationController
  DISPLAY_LIMIT = 15

  def index
    @boards = Board.preload(:last_entries, :feeds).sort_by(&:last_entry).reverse
  end

  def new; end

  def show
    @board_id = params[:id]
  end
end
