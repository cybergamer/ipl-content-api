class Matchup
  include Mongoid::Document
  include Mongoid::Timestamps

  # relations
  belongs_to :franchise
  # belongs_to :show
  belongs_to :event
  has_many :games, class_name: "MatchupGame", inverse_of: :matchup, :dependent => :destroy, :autosave => true
  has_and_belongs_to_many :teams
  belongs_to :winner, class_name: "Team", inverse_of: :matchups_won

  # fields
  field :best_of, :type => Integer, :default => 3

  # validations
  validates_numericality_of :best_of, :greater_than => 0
  validate :must_have_a_valid_number_of_teams
  validate :must_not_change_setup_after_games_have_started

  attr_accessible :best_of, :team_ids

  accepts_nested_attributes_for :teams, :winner

  def as_json(options = {})
    {:id => id, :best_of => best_of}.merge(MatchupSummary.new(self).as_json(options))
  end

  def must_have_a_valid_number_of_teams
    errors.add(:teams, 'Must have at least one team') unless teams.size > 0
    errors.add(:teams, 'Must have no more than two teams') if teams.size > 2
  end

  def must_not_change_setup_after_games_have_started
    if !games.started.empty?
      errors.add(:teams, 'Must not change teams after games have started') if team_ids_changed?
      errors.add(:best_of, 'Must not change best of after games have started') if best_of_changed?
    end
  end

end