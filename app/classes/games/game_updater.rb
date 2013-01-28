module Games
  class GameUpdater

    def update(target, data, options = {})
      updater = options[:updater] || Updater.new
      coercer = options[:coercer] || Games::DataHash
      updater.update(target, data, coercer)
    end

  end
end