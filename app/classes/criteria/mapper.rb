 module Criteria
  class Mapper

    MAPPERS = { :groups => Criteria::GroupsCriteriaMapper, :date_range => Criteria::DateRangeCriteriaMapper }

    def to_criteria(klass, criteria = [], options = {})
      mapped_criteria = Hash.new
      mappers = to_mappers(criteria)
      mappers.collect { |e| e.to_criteria(options) }.inject {|result, e| (result || Hash.new).merge(e) }
    end

    def to_mappers(criteria)
      criteria.collect { |e| Criteria::Mapper::MAPPERS[e.to_sym] }
    end

  end
end