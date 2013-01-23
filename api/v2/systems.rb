module IPL

  module Content

    module V2

      class Systems_API < Grape::API

        namespace :systems do

          desc "Returns pong."
          get :ping do
            {:ping => "pong"}
          end

        end

      end

    end

  end
end