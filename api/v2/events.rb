module IPL

  module Content

    module V2

      class Events_API < Grape::API

        namespace :events do

          desc "Returns events.", {
  :notes => <<-NOTE
    Events
    -----------------

    Are scheduled items broadcasted on a given stream. It may consist of a matchup with corresponding teams.

    Date Ranges
    -----------------

    Starting and ending datetimes should use the [RFC3339 format](http://www.ietf.org/rfc/rfc3339.txt). For example,

        2013-01-23T16:00:00-08:00

    Pagination
    -----------------

    Requests that return multiple items will be paginated to 50 items by default. You can specify further pages with the ?page parameter. For some resources, you can also set a custom page size up to 100 with the ?per_page parameter. Note that for technical reasons not all endpoints respect the ?per_page parameter, see franchises for example.

    The pagination info is included in [the Link header](http://www.w3.org/Protocols/9707-link-header.html). It is important to follow these Link header values instead of constructing your own URLs.

          Link: <http://example.com/items?page=3&per_page=100>; rel="next",
          <http://example.com/items?page=50&per_page=100>; rel="last"

    _Linebreak for readability._

    Sorting
    -----------------

    Sort events on a field in either ascending, asc, or descending, desc, order. Possible fields to sort by:

    * title
    * startsAt
    * endsAt
  NOTE
}
          params do
            optional :startsAt, type: String, desc: "Datetime when event starts."
            optional :groups, type: String, desc: "Comma-separated list of group names."
            optional :sortBy, type: String, desc: "Attribute to sort by. default: startsAt"
            optional :sortDirection, type: String, desc: "Direction to sort by. default: asc"
            optional :page, type: Integer, desc: "Page number. default: 1"
            optional :per_page, type: Integer, desc: "Number per page. default: 50"
          end
          get do
            params.merge!({:sortBy => "startsAt"}) unless params[:sortBy]
            query = Query.new.to_query(Event, params.merge({:valid_criteria => %w(groups date_range)}))
            lister = Lister.new
            response = lister.to_list(query, params)
            link_header = Pagination::LinkHeader.new.to_header(lister.paginator, request)
            header['Link'] = link_header if link_header
            response
          end

          desc "Return an event."
          params do
            requires :id, :bson_id => true
          end
          get ':id' do
            Event.find(params[:id])
          end

          desc "Creates an event."
          post do
            event = Events::Creator.new.create(params)
            if event.persisted?
              event
            else
              messages = event.errors.messages
              messages[:matchup] = event.matchup.errors.messages if event.matchup and !event.matchup.errors.messages.empty?
              error!({"error" => "invalid data provided", "detail" => messages}, 400)
            end
          end

          desc "Deletes an event."
          params do
            requires :id, :bson_id => true
          end
          delete ':id' do
            Event.find(params[:id]).destroy
          end

        end

      end

    end

  end
end