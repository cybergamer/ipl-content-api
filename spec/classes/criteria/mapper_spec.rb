require 'spec_helper'

describe Criteria::Mapper do

  describe "given valid criteria" do

    subject { Criteria::Mapper.new }

    let(:klass) { mock('SomeClass') }

    let(:criteria) { mock('criteria') }

    let(:foo_mapper) { mock('foo criteria mapper') }
    let(:bar_mapper) { mock('bar criteria mapper') }
    let(:mappers) { [foo_mapper, bar_mapper] }

    let(:options) { mock('options') }

    before do
      subject.stub(:to_mappers).with(criteria){ mappers }
      foo_mapper.stub(:to_criteria).with(options){ { :foo => 1 } }
      bar_mapper.stub(:to_criteria).with(options){ { :bar => 2 } }
    end

    it "returns mapped criteria" do
      subject.to_criteria(klass, criteria, options).should == { :foo => 1, :bar => 2 }
    end

  end

end