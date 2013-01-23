module IPL

  module Content

    module V2

      class Franchises_API < Grape::API

        namespace :franchises do

          desc "Returns franchises."
          get do
            Lister.new.to_list(Franchise.all, params)
          end

        end

      end

    end

  end
end