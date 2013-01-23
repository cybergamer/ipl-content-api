module IPL

  module Content

    module V2

      class Systems_API < Grape::API

        namespace :systems do

          desc "Returns pong."
          get :ping do
            header['Cache-Control'] = "must-revalidate, no-cache, no-store"
            header['Content-Type'] = "text/plain"
            {:ping => "pong"}
          end

        end

      end

    end

  end
end