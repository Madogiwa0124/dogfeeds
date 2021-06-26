module Feed::Rss
  class Filter
    INVALID_REGEXPS = [%r{<giga:.*>.*</giga:.*?>}].freeze

    def self.call(text)
      new(text).call
    end

    def initialize(text)
      @text = text
    end

    def call
      remove_invalid_string_by_regexps
    end

    private

    attr_reader :text

    def remove_invalid_string_by_regexps
      INVALID_REGEXPS.inject(text) do |result, regxp|
        result.match?(regxp) ? result.gsub(regxp, '') : result
      end
    end
  end
end
