require 'spec_helper'

describe MatchupGame do

  let(:game) { MatchupGame.new }

  let(:matchup) { mock('matchup', :team_ids => [123, 456]) }

  before do
    game.number = 1
    game.stub(:matchup) { matchup }
  end

  context "when validating" do

    context "and determining that winner is a participating team" do

      before do
        game.winner_id = 123
      end

      it "returns true if the winner is a team in the matchup" do
        game.winner_is_a_participating_team?.should be_true
      end

    end

    context "and winner is a participating team" do

      before do
        game.stub(:winner_is_a_participating_team?) { true }
        game.valid?
      end

      it "has no error on winner" do
        game.errors.messages[:winner].should be_nil
      end

    end

    context "and winner is not a participating team" do

      before do
        game.stub(:winner_is_a_participating_team?) { false }
        game.valid?
      end

      it "has an error on winner" do
        game.errors.messages[:winner].should include('Must be a participating team')
      end

    end

  end

end