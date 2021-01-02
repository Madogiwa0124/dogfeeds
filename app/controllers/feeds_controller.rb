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
    if post_form.create
      redirect_to feed_path(post_form.feed)
    else
      @feed = post_form.feed
      render :new
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :endpoint, tags: [])
  end
end
