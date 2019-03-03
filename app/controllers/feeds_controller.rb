class FeedsController < ApplicationController
  def index; end

  def show
    @feed = Feed.find(params[:id])
    @entries = @feed.entries.order(published_at: :desc)
  end

  def new
    @feed = Feed.new
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def create
    @feed = Feed.new
    ActiveRecord::Base.transaction do
      @feed.save_with_entry_create!(feed_params)
    end
    redirect_to feed_path(@feed)
  rescue StandardError => e
    logger.error(e)
    render :new
  end

  def update
    @feed = Feed.find(params[:id])
    @feed.save_with_entry_create!(feed_params)
    redirect_to feed_path(@feed)
  rescue StandardError => e
    logger.error(e)
    render :edit
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :endpoint)
  end
end
