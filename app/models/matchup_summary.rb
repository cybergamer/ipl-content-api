class MatchupSummary

  attr_accessor :matchup

  def initialize(matchup)
    @matchup = matchup
  end

  def as_json(options = {})
    { :teams => teams_data(options) }
  end

  def teams_data(options = {})
    @matchup.teams.collect { |team| MatchupTeam.new(@matchup, team).as_json(options) }
  end

end