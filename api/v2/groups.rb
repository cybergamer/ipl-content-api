module IPL

  module Content

    module V2

      class Groups_API < Grape::API

        namespace :groups do

          desc "Returns groups."
          get do
            Lister.new.to_list(Group.all, params)
          end

        end

      end

    end

  end
end