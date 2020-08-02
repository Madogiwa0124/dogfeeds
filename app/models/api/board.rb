module Api
  class Board
    def initialize(board:)
      @board = board
    end

    attr_reader :board

    def attributes
      {
        id: board.id,
        title: board.title,
        description: board.description,
        feedIds: board.feeds.ids
      }
    end
  end
end
