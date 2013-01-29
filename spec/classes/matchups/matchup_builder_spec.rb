require 'spec_helper'

describe Events::EventBuilder do

  let(:builder) { mock('generalized builder') }

  let(:coercer) { mock('Matchup data coercer') }

  let(:games_builder) { mock('Matchup games builder') }

  context "when building" do

    subject { Matchups::MatchupBuilder.new }

    let(:matchup) { mock('matchup') }

    let(:data) { mock('data') }

    let(:options) { mock('options') }

    before do
      builder.stub(:build) { matchup }
      games_builder.stub(:build_games).with(matchup)
    end

    it "returns an initialized matchupx" do
      subject.build(data, {:builder => builder, :coercer => coercer, :games_builder => games_builder}).should == matchup
    end

  end

end