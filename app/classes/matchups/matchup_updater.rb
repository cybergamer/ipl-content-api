module Matchups
  class MatchupUpdater

    def update(target, data, options = {})
      updater = options[:updater] || Updater.new
      coercer = options[:coercer] || Matchups::DataHash
      updater.update(target, data, coercer)
    end

  end
end