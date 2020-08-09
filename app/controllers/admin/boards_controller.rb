class Admin::BoardsController < Admin::ApplicationController
  def index
    @borads = Board.preload(:feeds).all.order(id: :desc)
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    @board.recreate_board_feeds!(feed_ids) if feed_ids.present?
    redirect_to admin_board_path(@board)
  rescue StandardError => e
    @board.error.add(base: e)
    logger.error(e)
    render :edit
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to admin_boards_path
  end

  private

  def feed_ids
    board_params['feed_ids'].select(&:present?)
  end

  def board_params
    params.require(:board).permit(:title, :feed_ids, feed_ids: [])
  end
end
