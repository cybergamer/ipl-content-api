require 'spec_helper'

describe Matchup do

  let(:matchup) { Matchup.new }

  context "when validating" do

    let(:team_1) { mock('team 1', :validated? => true) }
    let(:team_2) { mock('team 2', :validated? => true) }
    let(:team_3) { mock('team 3', :validated? => true) }

    context "and there are no teams" do

      before do
        matchup.stub(:valid?) { false }
      end

      it "has an error on teams" do
        errors = mock('errors', :messages => { :teams => ['Must have at least one team'] }  )
        matchup.stub(:errors) { errors }
        matchup.errors.messages[:teams].should include('Must have at least one team')
      end

    end

    context "and there is one team" do

      before do
        matchup.stub(:teams) { [team_1] }
        matchup.stub(:valid?) { true }
      end

      it "has no errors teams" do
        matchup.errors.messages[:teams].should be_nil
      end

    end

    context "and there are two teams" do

      before do
        matchup.stub(:teams) { [team_1, team_2] }
        matchup.stub(:valid?) { true }
      end

      it "has no errors teams" do
        matchup.errors.messages[:teams].should be_nil
      end

    end

    context "and there are many teams" do

      before do
        matchup.stub(:teams) { [team_1, team_2, team_3] }
        matchup.stub(:valid?) { false }
      end

      it "has no errors teams" do
        errors = mock('errors', :messages => { :teams => ['Must have no more than two teams'] }  )
        matchup.stub(:errors) { errors }
        matchup.errors.messages[:teams].should include('Must have no more than two teams')
      end

    end

  end

end