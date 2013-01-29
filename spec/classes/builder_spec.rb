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

  context "when authorizing" do

    subject { Builder.new }

    let(:attributes_translator) { mock('attributes_translator') }

    let(:whitelist) { mock('whitelist') }

    let(:authorizer) { mock('authorizer') }

    let(:attributes) { mock('attributes') }

    let(:translated_attributes) { mock('translated attributes') }

    before do
      attributes_translator.stub(:translate).with(attributes) { translated_attributes }
      whitelist.stub(:new).with( translated_attributes ) { authorizer }
    end

    it "returns an authorizer for whitelisted attributes" do
      subject.authorizer(attributes, {:attributes_translator => attributes_translator, :whitelist => whitelist}).should == authorizer
    end

  end

end