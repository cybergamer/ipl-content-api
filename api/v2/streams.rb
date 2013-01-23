module IPL

  module Content

    module V2

      class Streams_API < Grape::API

        namespace :streams do

          desc "Returns streams."
          get do
            query = Query.new.to_query(Stream, params.merge({:valid_criteria => %w(groups)}))
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            Lister.new.to_list(query, params)
          end

          desc "Return a stream."
          params do
            requires :id, :bson_id => true
          end
          get ':id' do
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            Stream.find(params[:id])
          end

        end

      end

    end

  end
end