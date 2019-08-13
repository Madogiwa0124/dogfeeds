class Feed::PostForm
  include ActiveModel::Model
  attr_accessor :id, :title, :endpoint, :tags, :feed

  def create!
    ActiveRecord::Base.transaction do
      feed_create!
      tags_create!
      entries_create!
    end
  end

  def update!
    ActiveRecord::Base.transaction do
      feed_update!
      tags_create!
      entries_create!
    end
  end

  private

  def feed_create!
    @feed = Feed.new(title: title, endpoint: endpoint)
    feed.save!
  end

  def feed_update!
    @feed = Feed.find(id)
    feed.assign_attributes(title: title, endpoint: endpoint)
    feed.save!
  end

  def entries_create!
    Feed::EntryCreater.new(feed).execute!
  rescue StandardError => e
    faild_entries_create
    raise e
  end

  def tags_create!
    @tags = tags.map { |tag| FeedTag.find_or_create_by!(body: tag) }
    feed.feed_taggings.delete_all
    tags.each { |tag| feed.feed_taggings.create!(feed_tag: tag) }
  end

  def faild_entries_create
    feed.errors.add(:base, '記事の一覧を取得するのに失敗しました。')
  end
end