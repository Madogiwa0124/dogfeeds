class Api::EntriesController < ApplicationController
  def index
    entries = Entry.where(feed_id: params[:feedId]).recent
    response = entries.map { |entry| ::Api::Entry.new(entry: entry).attributes }
    render json: response
  end
end
