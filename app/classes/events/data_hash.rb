require 'hashie'

module Events
  class DataHash < Hashie::Trash
    property :title
    property :starts_at
    property :ends_at
    property :stream_attributes, :from => :stream
    property :matchup_attributes #, :from => :matchup
  end
end