class MatchupGame
  include Mongoid::Document

  # fields
  field :number, :type => Integer
  field :starts_at, :type => Time
  field :ends_at, :type => Time
  field :poll_id

  # relations
  belongs_to :matchup, class_name: "Matchup", inverse_of: :games
  belongs_to :winner, class_name: "Team", inverse_of: :games_won

  # scopes
  default_scope order_by(:number => :asc)
  scope :not_started, where(starts_at: nil)
  scope :not_ended, where(ends_at: nil, winner: nil)
  scope :ended, where(:winner.ne => nil, :ends_at.ne => nil)

  def as_json(options = {})
    {:id => id, :number => number, :winner => winner}.reject { |k, v| v.nil? }
  end

end