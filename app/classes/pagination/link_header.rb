module Pagination
  class LinkHeader

    def to_header(paginator, request, options = {})
      next_link = options[:next_link] || Pagination::NextLink.new
      last_link = options[:last_link] || Pagination::LastLink.new
      [next_link, last_link].collect { |link| link.to_header(paginator, request, options) }.reject { |e| e.nil? }.join(", ")
    end

  end
end