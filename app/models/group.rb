class Group
  include Mongoid::Document
  include Mongoid::Slug

  # fields
  field :name, type: String
  field :image_url

  # validations
  validates_presence_of :name

  # relations
  slug :name
  has_and_belongs_to_many :franchises
  has_and_belongs_to_many :streams
  has_and_belongs_to_many :events
  has_and_belongs_to_many :calendars

  def as_json(options = {})
    {:id => id, :name => name, :slug => slug, :image_url => image_url}.reject { |k, v| v.nil? }
  end

end