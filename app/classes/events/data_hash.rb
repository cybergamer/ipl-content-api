require 'hashie'

module Events
  class DataHash < Hashie::Trash
    property :title
    property :starts_at
    property :ends_at
    property :stream_id
    property :matchup_id
  end
end