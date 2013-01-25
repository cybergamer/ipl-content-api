class Calendar
  include Mongoid::Document

  # relations
  belongs_to :franchise
  belongs_to :stream
  has_many :events, :dependent => :destroy
  has_and_belongs_to_many :groups

  # fields
  field :calendar_id
end