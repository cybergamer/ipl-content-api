require 'spec_helper'

describe Queries::Options::SortOptionMapper do

  subject { Queries::Options::SortOptionMapper.new }

  context "with field to sort by" do

    let(:field) { "foo" }

    it "should return mapped option" do
      subject.to_option({:sortBy => field}).should == {:sort=>[[:foo, 1]]}
    end

  end

  context "without field to sort by" do

    it "should return nil" do
      subject.to_option.should be_nil
    end

  end

end