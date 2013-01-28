class Query

  def to_query(klass, criteria = [], options = {})
    criteria_mapper = options[:criteria_mapper] || Criteria::Mapper.new
    options_mapper = options[:options_mapper] || Queries::Options::Mapper.new
    query_criteria = klass.where(criteria_mapper.to_criteria(klass, criteria, options))
    query_criteria.options = options_mapper.to_options(klass, options)
    query_criteria
  end

end