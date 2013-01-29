require 'spec_helper'

describe Translator do

  context "when translating data" do

    subject { Translator.new }

    let(:target) { mock('target') }

    let(:data) { mock('data') }

    let(:authorizer) { mock('authorizer') }

    let(:coercer) { mock('coercer') }

    let(:sanitizer) { mock('sanitizer') }

    let(:sanitized_data) { {:foo => 123} }

    let(:translated_data) { mock('translated data') }

    let(:nested_attributes_translator) { mock('translator for nested attributes') }

    let(:nested_attributes_translated_data) { {:bar => 456} }

    let(:final_data) { mock('finalized data') }

    let(:finalized_data) { mock('finalized data starting point') }

    before do
      sanitizer.stub(:sanitize).with(data, authorizer) { sanitized_data }
      nested_attributes_translator.stub(:translate).with(target, data) { nested_attributes_translated_data }
      finalized_data.stub(:merge!)
      coercer.stub(:new).with(finalized_data) { translated_data }
    end

    it "returns translated (sanitized and coerced) datax" do
      subject.translate(target, data, authorizer, coercer, {:sanitizer => sanitizer, :nested_attributes_translator => nested_attributes_translator, :finalized_data => finalized_data}).should == translated_data
    end

  end

end