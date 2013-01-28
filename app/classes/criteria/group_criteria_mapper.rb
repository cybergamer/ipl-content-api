module Criteria
  class GroupCriteriaMapper

    def to_criteria(options = {})
      groups = options[:groups] || nil
      criteria = Hash.new
      criteria.merge!({:group_ids.in => to_ids(groups)}) if groups
      criteria
    end

    def to_ids(slugs)
      slugs.split(',').collect { |slug| Group.find_by_slug(slug) }.reject { |group| group.nil? }.collect { |group| group.id.to_s }
    end

  end
end