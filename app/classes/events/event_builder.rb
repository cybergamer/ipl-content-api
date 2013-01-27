module Events
  class EventBuilder

    def build(data, options = {})
      builder = options[:builder] || Builder.new
      coercer = options[:coercer] || Events::DataHash
      matchup_builder = options[:matchup_builder] || Matchups::MatchupBuilder.new
      event = builder.build(Event, data, coercer)
      event.matchup = matchup_builder.build(data.matchup, options) if data.matchup
      event
    end

  end
end