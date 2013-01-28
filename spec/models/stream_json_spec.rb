require 'spec_helper'

describe Stream do

  subject { Stream.new }

  its(:to_json) { should_not be_nil }

end