module IPL

  module Content

    module V2

      class Franchises_API < Grape::API

        namespace :franchises do

          desc "Returns franchises."
          get do
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{6.hours.to_i}"
            Lister.new.to_list(Franchise.all, params)
          end

        end

      end

    end

  end
end