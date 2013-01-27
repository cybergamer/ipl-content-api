module Matchups
  module Games
    class Builder

      def build_games(matchup)
        (1..matchup.best_of).each do |i|
          game = MatchupGame.new
          game.number = i
          matchup.games << game
        end
      end

    end
  end
end