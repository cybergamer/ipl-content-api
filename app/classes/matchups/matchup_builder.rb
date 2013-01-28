module Matchups
  class MatchupBuilder

    def build(data, options = {})
      builder = options[:builder] || Builder.new
      coercer = options[:coercer] || Matchups::DataHash
      games_builder = options[:games_builder] || Matchups::Games::Builder.new
      matchup = builder.build(Matchup, data, coercer)
      games_builder.build_games(matchup)
      matchup
    end

  end
end