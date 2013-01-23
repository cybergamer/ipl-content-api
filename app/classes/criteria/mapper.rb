module Criteria
  class Mapper

    def to_criteria(klass, options = {})
      valid_criteria = options[:valid_criteria] || []
      groups_criteria_mapper = options[:groups_criteria_mapper] || Criteria::GroupsCriteriaMapper.new
      date_range_criteria_mapper = options[:date_range_criteria_mapper] || Criteria::DateRangeCriteriaMapper.new
      criteria = Hash.new
      valid_criteria.collect { |criteria| eval("#{criteria}_criteria_mapper") }.each do |mapper|
        criteria = mapper.to_criteria(criteria, options)
      end
      criteria
    end

  end
end