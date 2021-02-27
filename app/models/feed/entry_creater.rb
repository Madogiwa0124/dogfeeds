class Feed::EntryCreater
  attr_reader :feed

  def initialize(feed)
    @feed = feed
  end

  def execute!
    ActiveRecord::Base.transaction do
      Entry.where(feed: feed).delete_all
      # NOTE: validate済みのものを渡しているので警告を無効化
      # rubocop:disable Rails/SkipsModelValidations
      Entry.insert_all!(target_entries)
      # rubocop:enable Rails/SkipsModelValidations
      reloaded_feed = Feed.preload(:last_entry).find(feed.id)
      reloaded_feed.update!(last_published_at: reloaded_feed.last_entry.published_at)
    end
  end

  private

  def target_entries(now: Time.current)
    feed.parsed_items.map do |item|
      attributes = item.attributes.merge(feed_id: feed.id, created_at: now, updated_at: now)
      # valid?時のDBアクセスを抑制するためfeedのオブジェクトを代入する
      entry = Entry.new(attributes).tap { |obj| obj.feed = feed }
      # insert_all!はcallbackを無視してvalidationが走らないのでvalidなものだけ返却する
      entry.valid? ? attributes : nil
    end.compact
  end
end
