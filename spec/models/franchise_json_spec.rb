require 'spec_helper'

describe Franchise do

  context "as JSON" do

    let(:franchise) { Franchise.new(:name => 'Foo Bar Baz', :abbreviation => 'FBB') }

    subject { franchise.as_json }

    before do
      franchise.stub(:slug) { 'foo-bar-baz' }
    end

    it { should have_key(:id) }
    it { should have_key(:name) }
    it { should have_key(:slug) }
    it { should have_key(:abbreviation) }

  end

end