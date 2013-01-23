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
            response
          end

          desc "Return a matchup."
          params do
            requires :id, :bson_id => true
          end
          get ':id' do
            Matchup.find(params[:id])
          end

          desc "Creates an matchup."
          post do
            matchup = Matchups::Creator.new.create(params)
            if matchup.persisted?
              matchup
            else
              messages = matchup.errors.messages
              error!({"error" => "invalid data provided", "detail" => messages}, 400)
            end
          end

          desc "Deletes a matchup."
          params do
            requires :id, :bson_id => true
          end
          delete ':id' do
            Matchup.find(params[:id]).destroy
          end

        end

      end

    end

  end
end