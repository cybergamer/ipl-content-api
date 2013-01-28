require 'spec_helper'

describe MatchupGame do

  let(:game) { MatchupGame.new }

  let(:matchup) { mock('matchup', :team_ids => [123, 456]) }

  before do
    game.number = 1
    game.stub(:matchup) { matchup }
  end

  context "as JSON" do

    let(:winner) { mock('winner', :as_json => 'some JSON') }

    subject { game.as_json }

    before do
      game.stub(:winner) { winner }
    end

    it { should have_key(:id) }
    it { should have_key(:number) }
    it { should have_key(:winner) }
    it { should have_key(:status) }

  end

end