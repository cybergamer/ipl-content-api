require 'spec_helper'

describe Queries::Options::Mapper do

  subject { Queries::Options::Mapper.new }

  let(:klass) { mock('class') }

  let(:mapped_options) { mock('mapped options') }

  let(:sort_options_mapper) { mock('sort options mapper') }
  let(:sort_options_mapped) { {:foo => 123} }

  let(:fields_options_mapper) { mock('fields options mapper') }
  let(:fields_options_mapped) { {:bar => 456} }

  let(:mapped_options) { sort_options_mapped.merge(fields_options_mapped) }

  before do
    sort_options_mapper.stub(:to_option) { sort_options_mapped }
    fields_options_mapper.stub(:to_option) { fields_options_mapped }
  end

  it "returns mapped options" do
    subject.to_options(klass, {:sort_options_mapper => sort_options_mapper, :fields_options_mapper => fields_options_mapper}).should == mapped_options
  end

end