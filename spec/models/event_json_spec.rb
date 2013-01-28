require 'spec_helper'

describe Event do

  context "as JSON" do

    let(:event) { Event.new(:title => 'Foo', :starts_at => mock('start time', :to_i => 1), :ends_at => mock('end time', :to_i => 1)) }

    let(:stream) { mock('stream') }

    let(:matchup) { mock('matchup', :as_json => 'some JSON') }

    subject { event.as_json }

    before do
      stream.stub(:as_json).with({:projection => 'short'}) { 'some JSON' }
      event.stub(:stream) { stream }
      event.stub(:matchup) { matchup }
    end

    it { should have_key(:id) }
    it { should have_key(:title) }
    it { should have_key(:stream) }
    it { should have_key(:starts_at) }
    it { should have_key(:ends_at) }
    it { should have_key(:rebroadcast) }
    it { should have_key(:matchup) }
    it { should have_key(:groups) }

  end

end