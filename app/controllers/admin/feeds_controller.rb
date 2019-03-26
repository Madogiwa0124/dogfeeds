class Admin::FeedsController < Admin::ApplicationController
  def index
    @feeds = Feed.all
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])
    @feed.save_with_entry_create!(feed_params)
    redirect_to admin_feeds_path
  rescue StandardError => e
    logger.error(e)
    render :edit
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to admin_feeds_path
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :endpoint)
  end
end
