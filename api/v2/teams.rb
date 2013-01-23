module IPL

  module Content

    module V2

      class Teams_API < Grape::API

        namespace :teams do

          desc "Returns teams."
          get do
            query = Query.new.to_query(Team, params)
            Lister.new.to_list(query, params)
          end

        end

      end

    end

  end
end