require 'spec_helper'

describe Group do

  context "as JSON" do

    let(:group) { Group.new(:name => 'Foo Bar Baz', :image_url => mock('some URL')) }

    subject { group.as_json }

    before do
      group.stub(:slug) { 'foo-bar-baz' }
    end

    it { should have_key(:id) }
    it { should have_key(:name) }
    it { should have_key(:slug) }
    it { should have_key(:image_url) }

  end

end