module IPL

  module Content

    module V2

      class Streams_API < Grape::API

        namespace :streams do

          desc "Returns streams."
          get do
            query = Query.new.to_query(Stream, params.merge({:valid_criteria => %w(groups)}))
            Lister.new.to_list(query, params)
          end

          desc "Return a stream."
          params do
            requires :id, :bson_id => true
          end
          get ':id' do
            Stream.find(params[:id])
          end

        end

      end

    end

  end
end