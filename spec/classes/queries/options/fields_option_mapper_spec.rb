require 'spec_helper'

describe Queries::Options::FieldsOptionMapper do

  subject { Queries::Options::FieldsOptionMapper.new }

  context "with fields" do

    let(:fields) { "foo,bar" }

    it "should return mapped fields" do
      subject.to_option({:fields => fields}).should == {:fields=>{:foo=>1, :bar=>1, :_type=>1}}
    end

  end

  context "without fields" do

    it "should return empty hash" do
      subject.to_option.should be_empty
    end

  end

end