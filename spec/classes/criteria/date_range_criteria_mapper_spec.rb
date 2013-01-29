require 'spec_helper'

describe Criteria::DateRangeCriteriaMapper do

  subject { Criteria::DateRangeCriteriaMapper.new }

  context "when generating Criteria" do

    let(:options) { {} }

    before do
      options[:startsAt] = mock('start of current day')
      options[:endsAt] = mock('7 days after start')
    end

    it "returns criteria for a range matching the start and end date" do
      subject.to_criteria(options).should == { :starts_at.gte => options[:startsAt], :starts_at.lte => options[:endsAt] }
    end

  end

end