class BoardsController < ApplicationController
  def show
    @board = Board.find(params[:id])
    @entries = @board.entries.recent
  end
end
