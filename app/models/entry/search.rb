# frozen_string_literal: true

class Entry::Search
  DEFAULT_PER_PAGE = 8

  def self.call(params:, pager_enabled: true, per_page: DEFAULT_PER_PAGE)
    new(params, pager_enabled, per_page).call
  end

  def initialize(params, pager_enabled, per_page)
    @params = params
    @pager_enabled = pager_enabled
    @per_page = per_page
    @entries = []
  end

  def call
    @entries = Entry.recent
    filters.inject(@entries) { |entries, filter| filter.call(entries) }
  end

  private

  def filters
    [
      ->(entries) { params[:ids] ? entries.where(id: params[:ids]) : entries },
      ->(entries) { pager_enabled ? entries.pager(page: params[:page], per: per_page) : entries }
    ]
  end

  attr_reader :params, :entries, :pager_enabled, :per_page
end
