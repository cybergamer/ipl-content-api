class Calendar
  include Mongoid::Document

  # relations
  belongs_to :franchise
  belongs_to :stream
  has_many :events, :dependent => :destroy
  # has_many :matchups

  # fields
  field :calendar_id
end