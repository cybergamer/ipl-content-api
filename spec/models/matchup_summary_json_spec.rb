require 'spec_helper'

describe MatchupSummary do

  let(:matchup) { mock('matchup') }

  context "as JSON" do

    let(:summary) { MatchupSummary.new(matchup) }

    let(:team_1) { mock('team 1') }
    let(:team_2) { mock('team 2') }

    let(:game_1) { mock('game 1', :as_json => 'some JSON') }
    let(:game_2) { mock('game 2', :as_json => 'some JSON') }
    let(:game_3) { mock('game 3', :as_json => 'some JSON') }

    let(:winner) { mock('winner', :as_json => 'some JSON') }

    subject { summary.as_json }

    before do
      matchup_team_1 = MatchupTeam.stub(:new).with(matchup, team_1) { mock('matchup team 1', :as_json => 'some JSON') }
      matchup_team_2 = MatchupTeam.stub(:new).with(matchup, team_2) { mock('matchup team 2', :as_json => 'some JSON') }
      matchup.stub(:teams) { [team_1, team_2] }
      matchup.stub(:games) { [game_1, game_2, game_3] }
      matchup.stub(:winner) { winner }
    end

    it { should have_key(:teams) }
    it { should have_key(:games) }
    it { should have_key(:winner) }

  end

end