class Api::BoardsController < ApplicationController
  def index
    boards = Board.preload(:last_entries, :feeds)
                  .sort_by(&:last_entry).reverse
                  .map { |board| ::Api::Board.new(board: board).attributes }
    render json: boards
  end

  def show
    board = ::Api::Board.new(board: Board.preload(:feeds, :last_entries).find(params[:id]))
    render json: board.attributes
  end

  def create
    feeds = Feed.where(id: boards_params[:feed_ids])
    board = Board.create_with_feeds!(
      title: boards_params[:title],
      feeds: feeds
    )
    render json: { id: board.id }
  rescue StandardError => error
    logged_error(error)
    head :internal_server_error
  end

  private

  def boards_params
    params.require(:boards).permit(:title, feed_ids: [])
  end

  def logged_error
    logger.error(error)
    Rollbar.error(error)
  end
end
