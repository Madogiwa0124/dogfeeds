class BoardsController < ApplicationController
  def new
    @feeds = Feed.all.includes(:last_entry).order('entries.published_at DESC')
    @last_entries = @feeds.map(&:last_entry)
  end

  def show
    @board = Board.find(params[:id])
    @entries = @board.entries.recent
    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end
end
