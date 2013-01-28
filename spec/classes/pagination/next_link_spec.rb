require 'spec_helper'

describe Pagination::NextLink do

  describe "when generating header" do

    subject { Pagination::NextLink.new() }

    let(:options) { mock('options') }

    let(:paginator) { mock('paginator', :num_pages => 100) }

    let(:uri_parser) { mock('URI parser') }

    let(:uri) { mock('URI') }

    let(:query_parser) { mock('query parser') }

    let(:request) { mock('request', :host_with_port => 'example.com', :path => '/foo', :url => 'example.com/foo') }

    before do
      uri_parser.stub(:parse).with(request.url) { uri }
    end

    context "and it's the first page" do

      let(:params) { {} }

      before do
        paginator.stub(:page) { 1 }
        uri.stub(:query) { params }
        query_parser.stub(:parse_query).with(uri.query) { params }
      end

      it "returns header for the second page" do
        subject.to_header(paginator, request, {:uri_parser => uri_parser, :query_parser => query_parser}).should == "<http://#{request.host_with_port}#{request.path}?#{{:page => paginator.page + 1}.to_query}>; rel=\"next\""
      end

    end

    context "and it's a page in the middle" do

      let(:params) { {"page" => "50"} }

      before do
        paginator.stub(:page) { 50 }
        uri.stub(:query) { params }
        query_parser.stub(:parse_query).with(uri.query) { params }
      end

      it "returns header link for next page" do
        subject.to_header(paginator, request, {:uri_parser => uri_parser, :query_parser => query_parser}).should == "<http://#{request.host_with_port}#{request.path}?#{{:page => paginator.page + 1}.to_query}>; rel=\"next\""
      end

    end

    context "and it's the last page" do

      let(:params) { {"page" => "100"} }

      before do
        paginator.stub(:page) { 100 }
        uri.stub(:query) { params }
        query_parser.stub(:parse_query).with(uri.query) { params }
      end

      it "returns nil" do
        subject.to_header(paginator, request, {:uri_parser => uri_parser, :query_parser => query_parser}).should be_nil
      end

    end

  end

end