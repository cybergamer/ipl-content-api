require 'spec_helper'

describe Criteria::GroupCriteriaMapper do

  subject { Criteria::GroupCriteriaMapper.new }

  context "when generating criteria" do

    context "and no groups are provided" do

      let(:options) { {} }

      it "returns empty criteria" do
        subject.to_criteria(options).should be_empty
      end

    end

    context "and groups are provided" do

      let(:options) { { :groups => %(foo bar) } }

      before do
        subject.stub(:to_ids) { %w(123 456) }
      end

      it "returns criteria for the given groups" do
        subject.to_criteria(options).should == { :group_ids.in => %w(123 456) }
      end

    end

  end

  context "when extracting group ids" do

    let(:slugs) { 'foo,bar,baz' }

    let(:foo_group) { mock('foo group', :id => '123') }
    let(:bar_group) { mock('bar group', :id => '456') }

    before do
      Group.stub(:find_by_slug) { nil }
      Group.stub(:find_by_slug).with('foo') { foo_group }
      Group.stub(:find_by_slug).with('bar') { bar_group }
    end

    it "returns an array of ids for matching groups" do
      subject.to_ids(slugs).should == %w(123 456)
    end

  end

end