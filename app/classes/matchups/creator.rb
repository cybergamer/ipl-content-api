module Matchups
  class Creator

    def create(data, options = {})
      data_handler = options[:data_handler] || Matchups::Data::Handler.new
      matchup = Matchup.create(data_handler.handle(data, options))
      if matchup.persisted?
        after_create(matchup, options)
        matchup.reload
      else
        matchup
      end
    end

    def after_create(matchup, options = {})
      games_builder = options[:games_builder] || Matchups::Games::Builder.new
      games_builder.build_games(matchup)
    end

  end
end