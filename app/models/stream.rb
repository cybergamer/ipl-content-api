class Stream
  include Mongoid::Document

  # fields
  field :name
  field :ign_id
  field :twitch_id
  field :title # twitch provider
  field :image_url # twitch provider
  field :status, :type => String, :default => "off air"

  # validations
  validates_presence_of :name

  # relations
  belongs_to :franchise
  has_one :calendar, :dependent => :destroy
  has_many :events
  embeds_one :ign_data, class_name: "Ign::Streams::Data", inverse_of: :stream
  embeds_one :twitch_data, class_name: "Twitch::Streams::Data", inverse_of: :stream
  has_and_belongs_to_many :groups

  # scopes
  scope :on_air, where(status: 'on air')

  def as_json( options = {} )
    if options and options[:projection]
      case options[:projection]
        when "short"
          return {:id => id, :name => name}
      end
    end
    {:id => id, :name => name, :title => title, :franchise => franchise.as_json(options), :groups => groups, :providers => %w(ign twitch).collect { |e| send("#{e}_data").as_json(options) }, :image_url => image_url}.reject { |k, v| v.nil? }
  end

end