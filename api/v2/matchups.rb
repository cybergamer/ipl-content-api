module IPL
  module Content
    module V2
      class Matchups_API < Grape::API

        namespace :matchups do

          desc "Returns matchups."
          get do
            query = Query.new.to_query(Matchup, params.merge({:valid_criteria => %w(groups)}))
            lister = Lister.new
            response = lister.to_list(query, params)
            link_header = Pagination::LinkHeader.new.to_header(lister.paginator, request)
            header['Link'] = link_header if link_header
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            response
          end

          desc "Return a matchup."
          params do
            requires :id, :bson_id => true
          end
          get ':id' do
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            Matchup.find(params[:id])
          end

          desc "Creates an matchup."
          post do
            matchup = Matchups::MatchupBuilder.new.build(params)
            if matchup.save
              matchup
            else
              messages = matchup.errors.messages
              error!({"error" => "invalid data provided", "detail" => messages}, 400)
            end
          end

          desc "Updates a matchup."
          params do
            requires :id, :bson_id => true
          end
          put ':id' do
            matchup = Matchup.find(params[:id])
            result, errors = Matchups::MatchupUpdater.new.update(matchup, params)
            if result
              {"success" => result}
            else
              error!({"error" => "invalid data provided", "detail" => errors}, 400)
            end
          end

          desc "Deletes a matchup."
          params do
            requires :id, :bson_id => true
          end
          delete ':id' do
            result = Matchup.find(params[:id]).destroy
            if result
              {"success" => result}
            else
              error!({"error" => "Could not delete matchup"}, 400)
            end
          end

        end

      end
    end
  end
end