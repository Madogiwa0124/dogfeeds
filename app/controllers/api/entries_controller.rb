class Api::EntriesController < ApplicationController
  PER_PAGE = 8

  def index
    entries = Entry::Search.call(params: params, pager_enabled: pager_enabled, per_page: PER_PAGE)
    serialize = ->(entry) { ::Api::Entry.new(entry: entry).attributes }
    render json: entries.map(&serialize)
  end

  private

  def pager_enabled
    (params[:pager].presence || 'true') == 'true'
  end
end
