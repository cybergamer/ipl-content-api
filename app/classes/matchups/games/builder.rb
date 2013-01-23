module Matchups
  module Games
    class Builder

      def build_games(matchup)
        (1..matchup.best_of).each do |i|
          matchup.games << MatchupGame.new(:number => i)
        end
      end

    end
  end
end