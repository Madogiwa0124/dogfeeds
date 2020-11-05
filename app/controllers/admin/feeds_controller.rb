class Admin::FeedsController < Admin::ApplicationController
  def index
    @feeds = Feed.all.order(id: :desc)
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    post_form = Feed::PostForm.new(feed_params.merge(id: params[:id]))
    post_form.update!
    redirect_to feed_path(post_form.feed)
  rescue StandardError => e
    @feed = post_form.feed
    logger.error(e)
    Rollbar.error(e)
    render :edit
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to admin_feeds_path
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :endpoint, tags: [])
  end
end
