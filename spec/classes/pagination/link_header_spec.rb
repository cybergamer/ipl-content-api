require 'spec_helper'

describe Pagination::LinkHeader do

  context "when generating header" do

    subject { Pagination::LinkHeader.new }

    let(:next_link) { mock('next link') }
    let(:last_link) { mock('last link') }

    let(:paginator) { mock('paginator') }
    let(:request) { mock('request') }

    let(:options) { { :next_link => next_link, :last_link => last_link } }

    before do
      next_link.stub(:to_header).with(paginator, request, options) { 'next link for header' }
      last_link.stub(:to_header).with(paginator, request, options) { 'last link for header' }
    end

    it "returns the pagination links for the Link header" do
      subject.to_header(paginator, request, options).should == 'next link for header, last link for header'
    end

  end

end