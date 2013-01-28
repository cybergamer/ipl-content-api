require 'spec_helper'

describe Team do

  subject { Team.new }

  its(:to_json) { should_not be_nil }

end