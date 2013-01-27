module Games
  class DataHash < Hashie::Trash
    property :starts_at
    property :ends_at
    property :status
    property :winner_id
  end
end