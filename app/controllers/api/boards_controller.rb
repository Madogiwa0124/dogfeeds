class Api::BoardsController < ApplicationController
  def create
    feeds = Feed.where(id: boards_confirm_params[:feed_ids])
    board = Board.create_with_board_feeds!(feeds: feeds)
    render json: { id: board.id }
  rescue StandardError => e
    logger.error(e)
    head :internal_server_error
  end

  private

  def boards_confirm_params
    params.require(:boards).permit(feed_ids: [])
  end
end
