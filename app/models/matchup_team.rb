class MatchupTeam

  attr_accessor :matchup, :team

  def initialize(matchup, team)
    @matchup = matchup
    @team = team
  end

  def as_json(options = {})
    @team.as_json(options).merge({:points => points})
  end

  def points
    @matchup.games.ended.select { |game| game.winner == @team }.size
  end

end