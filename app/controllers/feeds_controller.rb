class FeedsController < ApplicationController
  def index
    @feeds = Feed.all.includes(:last_entry).order('entries.published_at DESC')
  end

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
    @feed = Feed.new(feed_params)
    if @feed.save
      Feed::EntryCreater.new(@feed).execute
      redirect_to feed_path(@feed)
    else
      render :new
    end
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.save
      Feed::EntryCreater.new(@feed).execute
      redirect_to feed_path(@feed)
    else
      render :edit
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :endpoint)
  end
end
