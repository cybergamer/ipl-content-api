class Matchup
  include Mongoid::Document
  include Mongoid::Timestamps

  # relations
  belongs_to :franchise
  # belongs_to :show
  belongs_to :event
  has_many :games, class_name: "MatchupGame", inverse_of: :matchup
  has_and_belongs_to_many :teams

  # fields
  field :best_of, :type => Integer, :default => 3
  field :winner

  # validations
  validates_numericality_of :best_of, :greater_than => 0
  validate :must_have_a_team

  attr_accessible :best_of, :team_ids

  accepts_nested_attributes_for :teams

  def as_json(options = {})
    {:id => id}.merge(MatchupSummary.new(self).as_json(options))
  end

  def must_have_a_team
    errors.add(:teams, 'Must have at least one team') unless teams.size > 0
  end

end