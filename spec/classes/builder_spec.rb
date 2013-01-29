require 'spec_helper'

describe Builder do

  context "when building" do

    subject { Builder.new }

    let(:klass) { mock('class') }

    let(:data) { mock('data') }

    let(:authorizer) { mock('authorizer') }

    let(:coercer) { mock('coercer') }

    let(:translator) { mock('translator') }

    let(:initialized_object) { mock('initialized object') }

    let(:options) { {:translator => translator, :authorizer => authorizer} }

    let(:translated_data) { mock('translated data') }

    before do
      translator.stub(:translate).with(klass, data, authorizer, coercer, options) { translated_data }
      klass.stub(:new).with(translated_data) { initialized_object }
    end

    it "returns initialized object with the given data" do
      subject.build(klass, data, coercer, options).should == initialized_object
    end

  end

end