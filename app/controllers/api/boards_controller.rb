class Api::BoardsController < ApplicationController
  def show
    board = ::Api::Board.new(board: Board.preload(:feeds).find(params[:id]))
    render json: board.attributes
  end

  def create
    feeds = Feed.where(id: boards_params[:feed_ids])
    board = Board.create_with_board_feeds!(
      title: boards_params[:title],
      feeds: feeds
    )
    render json: { id: board.id }
  rescue StandardError => e
    logger.error(e)
    head :internal_server_error
  end

  private

  def boards_params
    params.require(:boards).permit(:title, feed_ids: [])
  end
end
