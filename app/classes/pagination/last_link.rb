module Pagination
  class LastLink

    def to_header(paginator, request, options = {})
      uri_parser = options[:uri_parser] || URI
      query_parser = options[:query_parser] || Rack::Utils
      uri = uri_parser.parse(request.url)
      params = query_parser.parse_query(uri.query)
      params["page"] = paginator.num_pages
      url = ["http://#{request.host_with_port}#{request.path}", params.to_query].join("?")
      "<#{url}>; rel=\"last\""
    end

  end
end