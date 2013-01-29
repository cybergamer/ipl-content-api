require 'spec_helper'

describe Events::EventBuilder do

  let(:builder) { mock('generalized builder') }

  let(:coercer) { mock('Event data coercer') }

  context "when building" do

    subject { Events::EventBuilder.new }

    let(:event) { mock('event') }

    let(:data) { mock('data') }

    let(:options) { mock('options') }

    before do
      builder.stub(:build) { event }
    end

    context "without a matchup" do

      before do
        data.stub(:matchup) { nil }
      end

      it "returns an initialized event" do
        subject.build(data, {:builder => builder, :coercer => coercer}).should == event
      end

    end

    context "with a matchup" do

      let(:matchup) { mock('matchup') }

      let(:matchup_builder) { mock('matchup builder') }

      let(:options) { {:builder => builder, :coercer => coercer, :matchup_builder => matchup_builder} }

      before do
        data.stub(:matchup) { matchup }
        matchup_builder.stub(:build).with(data.matchup,options) { matchup }
        event.stub(:matchup=).with(matchup)
        event.stub(:matchup) { matchup }
      end

      it "returns an initialized event with an initialized matchup" do
        subject.build(data, options).should == event
        event.matchup.should == matchup
      end

    end

  end

end