module Criteria
  class DateRangeCriteriaMapper

    def to_criteria(options = {})
      startsAt = options[:startsAt] || Time.now.midnight
      endsAt = options[:endsAt] || startsAt + 7.days
      criteria = Hash.new
      criteria.merge!({:starts_at.gte => startsAt}) if startsAt
      criteria.merge!({:starts_at.lte => endsAt}) if endsAt
      criteria
    end

  end
end