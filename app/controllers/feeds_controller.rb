class FeedsController < ApplicationController
  def index
    @entries = Entry.all.includes(:feed).order(published_at: :desc)
  end

  def show
    @feed = Feed.includes(:entries).find(params[:id])
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
