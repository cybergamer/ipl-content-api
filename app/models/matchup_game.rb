class MatchupGame
  include Mongoid::Document

  STATUSES = %w(ready active done)

  # fields
  field :number, :type => Integer, :default => 1
  field :starts_at, :type => Time
  field :ends_at, :type => Time
  field :poll_id
  field :status, :type => String, :default => 'ready'

  # relations
  belongs_to :matchup, class_name: "Matchup", inverse_of: :games
  belongs_to :winner, class_name: "Team", inverse_of: :games_won

  # scopes
  default_scope order_by(:number => :asc)
  scope :started, where(:starts_at.ne => nil)
  scope :not_started, where(starts_at: nil)
  scope :not_ended, where(ends_at: nil, winner: nil)
  scope :ended, where(:winner.ne => nil, :ends_at.ne => nil)

  # validations
  validates_inclusion_of :status, :in => STATUSES, :message => "Must be the following: #{STATUSES.join(", ")}"
  validate :winner_must_be_a_participating_team

  attr_accessible :starts_at, :ends_at, :status, :winner_id
  attr_protected :number

  accepts_nested_attributes_for :winner

  def as_json(options = {})
    {:id => id, :number => number, :winner => winner, :status => status}.reject { |k, v| v.nil? }
  end

  def winner_must_be_a_participating_team
    errors.add(:winner, 'Must be a participating team') if !winner_is_a_participating_team?
  end

  def winner_is_a_participating_team?
    winner_id.present? ? matchup.team_ids.include?(winner_id) : true
  end

end