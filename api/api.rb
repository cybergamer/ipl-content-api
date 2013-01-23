module IPL

  module Content

    class API < Grape::API

      mount ::IPL::Content::API_V2
      add_swagger_documentation :mount_path => '/content/v2/docs', :api_version => 'v2', :base_path => 'http://esports.ign.com', :hide_documentation_path => true, :markdown => true

    end

  end

end