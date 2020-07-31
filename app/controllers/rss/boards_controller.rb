class Rss::BoardsController < ApplicationController
  DISPLAY_LIMIT = 15

  def show
    @board = Board.preload(:feeds).find(params[:id])
    @entries = @board.entries.recent.limit(DISPLAY_LIMIT)
    render layout: false
  end
end
