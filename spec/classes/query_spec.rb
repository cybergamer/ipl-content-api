require 'spec_helper'

describe Query do

  context "when generating query" do

    subject { Query.new }

    let(:klass) { mock('object class') }

    let(:criteria_mapper) { mock('criteria mapper') }

    let(:options_mapper) { mock('options mapper') }

    let(:options) { { :criteria_mapper => criteria_mapper, :options_mapper => options_mapper } }

    let(:query_criteria) { mock('criteria for query') }

    let(:criteria_params) { mock('criteria params') }

    before do
      mapped_criteria = mock('mapped criteria')
      criteria_mapper.stub(:to_criteria).with(klass, criteria_params, options) { mapped_criteria }
      klass.stub(:where).with(mapped_criteria) { query_criteria }

      mapped_options = mock('mapped options')
      options_mapper.stub(:to_options).with(klass, options) { mapped_options }
      query_criteria.stub(:options=)
      query_criteria.stub(:options) { mapped_options }
    end

    it "returns criteria for query" do
      subject.to_query(klass, criteria_params, options).should == query_criteria
    end

  end

end