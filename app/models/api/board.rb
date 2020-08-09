module Api
  class Board
    def initialize(board:)
      @board = board
      @last_entry = board.last_entry
    end

    def attributes
      {
        id: board.id,
        title: board.title,
        description: board.description,
        feedIds: board.feeds.ids,
        lastEntry: last_entry_attirbutes
      }
    end

    private

    attr_reader :board, :last_entry

    def last_entry_attirbutes
      last_entry ? Entry.new(entry: last_entry).attributes : nil
    end
  end
end
