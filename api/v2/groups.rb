module IPL

  module Content

    module V2

      class Groups_API < Grape::API

        namespace :groups do

          desc "Returns groups."
          get do
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{6.hours.to_i}"
            Lister.new.to_list(Group.all, params)
          end

        end

      end

    end

  end
end