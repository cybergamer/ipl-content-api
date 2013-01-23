module IPL

  module Content

    module V2

      class Videos_API < Grape::API

        namespace :videos do

          desc "Returns videos."
          get do
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            Lister.new.to_list(SourceVideo.all, params)
          end

        end

      end

    end

  end
end