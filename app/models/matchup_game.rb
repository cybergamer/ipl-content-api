class MatchupGame
  include Mongoid::Document

  # fields
  field :number, :type => Integer
  field :starts_at, :type => Time
  field :ends_at, :type => Time
  field :winner
  field :poll_id

  # relations
  embedded_in :matchup, class_name: "Matchup", inverse_of: :games

  # scopes
  scope :not_started, where(starts_at: nil)
  scope :not_ended, where(ends_at: nil, winner: nil)
  scope :ended, where(:winner.ne => nil, :ends_at.ne => nil)

  def as_json(options = {})
    {
      :game => {
        :id => self.id,
        :number => self.number
      }
    }
  end

end