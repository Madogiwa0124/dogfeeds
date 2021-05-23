# frozen_string_literal: true

require 'lograge'

class Lograge::Formatters::MarkedKeyValue < Lograge::Formatters::KeyValue
  INFO_MARK = '🙂'
  SUCCES_MARK = '😃'
  REDIRECT_MARK = '😗'
  CLIENT_ERROR_MARK = '🤔'
  SERVER_ERROR_MARK = '😱'

  def call(data)
    result = super(data)
    mark = status_to_mark(data[:status].to_i)
    "#{mark} #{result}"
  end

  def status_to_mark(status)
    case status
    when 100...200 then INFO_MARK
    when 200...300 then SUCCES_MARK
    when 300...400 then REDIRECT_MARK
    when 400...500 then CLIENT_ERROR_MARK
    when 500...    then SERVER_ERROR_MARK
    else ' '
    end
  end
end
