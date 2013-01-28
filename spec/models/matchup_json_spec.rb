require 'spec_helper'

describe Matchup do

  context "as JSON" do

    let(:matchup) { Matchup.new }

    let(:summary) { mock('summary for matchup', :as_json => {:teams => 'some JSON', :games => 'some JSON', :winner => 'some JSON'}) }

    subject { matchup.as_json }

    before do
      MatchupSummary.stub(:new).with(matchup) { summary }
    end

    it { should have_key(:id) }
    it { should have_key(:teams) }
    it { should have_key(:games) }
    it { should have_key(:winner) }

  end

end