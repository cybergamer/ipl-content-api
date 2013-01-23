class Franchise
  include Mongoid::Document
  include Mongoid::Slug

  # fields
  field :name, type: String
  field :abbreviation, type: String

  # validations
  validates_presence_of :name

  # relations
  slug :name
  has_and_belongs_to_many :groups

  def as_json(options = {})
    {:id => id, :name => name, :slug => slug, :abbreviation => abbreviation}.reject { |k, v| v.nil? }
  end
end