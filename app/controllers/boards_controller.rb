class BoardsController < ApplicationController
  DISPLAY_LIMIT = 15

  def index
    @boards = Board.eager_load(:last_entries, :feeds)
                   .order('entries.published_at DESC NULLS LAST')
  end

  def new
    @feeds = Feed.all.includes(:last_entry).order('entries.published_at DESC')
    @last_entries = @feeds.map(&:last_entry)
  end

  def show
    @board = Board.includes(:feeds).find(params[:id])
    @entries = @board.entries.recent.limit(DISPLAY_LIMIT)
    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end
end
