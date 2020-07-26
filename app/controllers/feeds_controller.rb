class FeedsController < ApplicationController
  def index; end

  def show
    @feed_id = params[:id]
  end

  def new
    @feed = Feed.new
  end

  def create
    post_form = Feed::PostForm.new(feed_params)
    post_form.create!
    redirect_to feed_path(post_form.feed)
  rescue StandardError => e
    @feed = post_form.feed
    logger.error(e)
    render :new
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :endpoint, tags: [])
  end
end
