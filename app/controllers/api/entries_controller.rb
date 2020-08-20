class Api::EntriesController < ApplicationController
  PER_PAGE = 8

  def index
    entries = Entry.recent.pager(page: params[:page], per: PER_PAGE)
    response = entries.map { |entry| ::Api::Entry.new(entry: entry).attributes }
    render json: response
  end
end
