module Twitch

  module Streams

    class Data
      include Mongoid::Document

      # relations
      embedded_in :stream, class_name: "Stream", inverse_of: :twitch_data

      # fields
      field :source, :type => Hash

      def as_json(options = {})
        {:name => "twitch", :id => stream.send("twitch_id"), :data => source}
      end

    end

  end

end