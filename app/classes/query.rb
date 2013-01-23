class Query

  def to_query(klass, options = {})
    criteria_mapper = options[:criteria_mapper] || Criteria::Mapper.new
    options_mapper = options[:options_mapper] || Queries::Options::Mapper.new
    criteria = klass.where(criteria_mapper.to_criteria(klass, options))
    criteria.options = options_mapper.to_options(klass, options)
    criteria
  end

end