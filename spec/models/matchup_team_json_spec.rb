require 'spec_helper'

describe MatchupTeam do

  let(:matchup) { mock('matchup') }

  let(:team) { mock('this team') }

  let(:game_1) { mock('game won by team', :winner => team) }
  let(:game_2) { mock('game lost by team', :winner => mock('the other team')) }
  let(:game_3) { mock('another game won by team', :winner => team) }
  let(:games) { mock('games', :ended => [game_1, game_2, game_3] ) }

  let(:points) { 456 }

  subject { MatchupTeam.new(matchup, team) }

  context "when calculating points" do

    before do
      matchup.stub(:games) { games }
    end

    it "returns number of games won by team" do
      subject.points.should == 2
    end

  end

end