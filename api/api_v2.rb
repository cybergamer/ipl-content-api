module IPL

  module Content

    class API_V2 < Grape::API

      version 'v2', :using => :path
      prefix 'content'
      format :json

      rescue_from :all

      before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'
      end

      mount IPL::Content::V2::Events_API
      mount IPL::Content::V2::Franchises_API
      mount IPL::Content::V2::Groups_API
      mount IPL::Content::V2::Matchups_API
      mount IPL::Content::V2::Streams_API
      mount IPL::Content::V2::Systems_API
      mount IPL::Content::V2::Teams_API
      mount IPL::Content::V2::Videos_API

    end

  end

end