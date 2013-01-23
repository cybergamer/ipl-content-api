module IPL

  module Content

    module V2

      class Videos_API < Grape::API

        namespace :videos do

          desc "Returns videos."
          get do
            Lister.new.to_list(SourceVideo.all, params)
          end

        end

      end

    end

  end
end