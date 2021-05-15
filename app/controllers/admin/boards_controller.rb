class Admin::BoardsController < Admin::ApplicationController
  def index
    @borads = Board.preload(:feeds).all.order(id: :desc)
  end

  def show
    @board = Board.preload(:feeds).find(params[:id])
  end

  def edit
    @board = Board.preload(:feeds).find(params[:id])
  end

  def update
    @board = Board.preload(:feeds).find(params[:id])
    @board.update_with_recreate_feeds!(title: title, feed_ids: feed_ids)
    redirect_to admin_board_path(@board)
  rescue StandardError => error
    logged_error(error)
    render :edit
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to admin_boards_path
  end

  private

  def logged_error(error)
    logger.error(error)
    Rollbar.error(error)
  end

  def title
    board_params['title']
  end

  def feed_ids
    board_params['feed_ids'].select(&:present?)
  end

  def board_params
    params.require(:board).permit(:title, :feed_ids, feed_ids: [])
  end
end
