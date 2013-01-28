module IPL

  module Content

    module V2

      class Teams_API < Grape::API

        namespace :teams do

          desc "Returns teams."
          get do
            query = Query.new.to_query(Team, [], params)
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            Lister.new.to_list(query, params)
          end

        end

      end

    end

  end
end