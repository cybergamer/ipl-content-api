class Team
  include Mongoid::Document
  include Mongoid::Slug

  # relations
  slug :name
  has_and_belongs_to_many :matchups
  has_many :games_won, class_name: "MatchupGame", inverse_of: :winner

  # fields
  field :name
  field :image_url

  # validations
  validates_presence_of :name
  validates_uniqueness_of :name

  def as_json(options = {})
    {:id => id, :name => name, :image_url => image_url }.reject { |k, v| v.nil? }
  end
end