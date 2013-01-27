module IPL
  module Content
    module V2
      class Events_API < Grape::API

        namespace :events do

          desc "Returns events.", {
  :notes => <<-NOTE
    Events
    -----------------

    Are scheduled items broadcasted on a given stream. It may consist of a matchup.
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
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            response
          end

          desc "Return an event."
          params do
            requires :id, :bson_id => true
          end
          get ':id' do
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            Event.find(params[:id])
          end

          desc "Creates an event."
          post do
            event = Events::EventBuilder.new.build(params)
            if event.save
              event
            else
              messages = event.errors.messages
              messages[:matchup] = event.matchup.errors.messages if event.matchup
              error!({"error" => "invalid data provided", "detail" => messages}, 400)
            end
          end

          desc "Deletes an event."
          params do
            requires :id, :bson_id => true
          end
          delete ':id' do
            result = Event.find(params[:id]).destroy
            if result
              {"success" => result}
            else
              error!({"error" => "Could not delete event"}, 400)
            end
          end

        end

      end
    end
  end
end