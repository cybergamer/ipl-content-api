class MatchupSummary

  attr_accessor :matchup

  def initialize(matchup)
    @matchup = matchup
  end

  def as_json(options = {})
    { :teams => teams_data(options), :games => games_data(options), :winner => winner_data(options) }.reject { |k, v| v.nil? }
  end

  def teams_data(options = {})
    @matchup.teams.collect { |team| MatchupTeam.new(@matchup, team).as_json(options) }
  end

  def games_data(options = {})
    @matchup.games.collect { |game| game.as_json(options) }
  end


  def winner_data(options = {})
    @matchup.winner.as_json(options)
  end

end