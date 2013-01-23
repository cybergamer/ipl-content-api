module Pagination
  class NextLink

    def to_header(paginator, request, options = {})
      uri_parser = options[:uri_parser] || URI
      query_parser = options[:query_parser] || Rack::Utils
      uri = uri_parser.parse(request.url)
      params = query_parser.parse_query(uri.query)
      if params["page"]
        next_page = params["page"].to_i + 1
      else
        next_page = paginator.page + 1
      end
      return if next_page >= paginator.num_pages
      params["page"] = next_page
      url = ["http://#{request.host_with_port}#{request.path}", params.to_query].join("?")
      "<#{url}>; rel=\"next\""
    end

  end
end