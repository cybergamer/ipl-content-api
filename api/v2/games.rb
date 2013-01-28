module IPL
  module Content
    module V2
      class Games_API < Grape::API

        namespace :games do

          desc "Return a game."
          params do
            requires :id, :bson_id => true
          end
          get ':id' do
            header['Last-Modified'] = Time.now.httpdate
            header['Cache-Control'] = "public, max-age=#{5.minutes.to_i}"
            MatchupGame.find(params[:id])
          end

          desc "Updates a game."
          params do
            requires :id, :bson_id => true
          end
          put ':id' do
            game = MatchupGame.find(params[:id])
            result, errors = Games::GameUpdater.new.update(game, params)
            if result
              {"success" => result}
            else
              error!({"error" => "invalid data provided", "detail" => errors}, 400)
            end
          end

        end

      end
    end
  end
end