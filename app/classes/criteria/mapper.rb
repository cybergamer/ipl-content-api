 module Criteria
  class Mapper

    def to_criteria(klass, criteria = [], options = {})
      mapped_criteria = Hash.new
      mappers = to_mappers(criteria)
      mappers.collect { |e| e.to_criteria(options) }.inject {|result, e| (result || Hash.new).merge(e) }
    end

    def to_mappers(criteria)
      criteria.collect { |e| eval("Criteria::#{e.classify.singularize}CriteriaMapper").new }
    end

  end
end