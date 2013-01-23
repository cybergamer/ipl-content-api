module Streams
  module Data
    class JSONParser

      def parse(data)
        JSON.parse(data)
      end

    end
  end
end