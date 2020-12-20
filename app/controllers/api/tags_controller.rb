class Api::TagsController < ApplicationController
  TAGS_LIMIT = 50

  def index
    render json: FeedTag.counted_tags(limit: TAGS_LIMIT)
  end
end
