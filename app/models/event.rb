class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  # relations
  belongs_to :calendar
  belongs_to :stream
  # belongs_to :show
  has_one :matchup, :dependent => :destroy, :autosave => true
  has_and_belongs_to_many :groups

  # fields
  field :title
  field :starts_at, :type => Time
  field :ends_at, :type => Time
  field :rebroadcast, :default => false

  # validations
  #validates_presence_of :title, :starts_at, :ends_at, :stream_id

  attr_accessible :title, :starts_at, :ends_at, :stream, :stream_attributes, :matchup_attributes

  accepts_nested_attributes_for :stream, :matchup

  def as_json( options = {})
    {:id => id, :title => title, :stream => stream.as_json({:projection => "short"}), :starts_at => starts_at, :ends_at => ends_at, :rebroadcast => rebroadcast, :matchup => matchup, :groups => groups}.reject { |k, v| v.nil? }
  end

end