require 'spec_helper'

describe Pagination::LastLink do

  describe "when generating header" do

    subject { Pagination::LastLink.new() }

    let(:options) { mock('options') }

    let(:paginator) { mock('paginator', :num_pages => 100) }

    let(:uri_parser) { mock('URI parser') }

    let(:uri) { mock('URI') }

    let(:query_parser) { mock('query parser') }

    let(:request) { mock('request', :host_with_port => 'example.com', :path => '/foo', :url => 'example.com/foo') }

    let(:params) { {} }

    before do
      uri_parser.stub(:parse).with(request.url) { uri }
      paginator.stub(:page) { 1 }
      uri.stub(:query) { params }
      query_parser.stub(:parse_query).with(uri.query) { params }
    end

    it "returns header for the second page" do

      subject.to_header(paginator, request, {:uri_parser => uri_parser, :query_parser => query_parser}).should == "<http://#{request.host_with_port}#{request.path}?#{{:page => paginator.num_pages}.to_query}>; rel=\"last\""
    end

  end

end