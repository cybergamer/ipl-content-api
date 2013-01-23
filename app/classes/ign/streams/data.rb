module Ign

  module Streams

    class Data
      include Mongoid::Document

      # relations
      embedded_in :stream, class_name: "Stream", inverse_of: :ign_data

      # fields
      field :source, :type => Hash

      def as_json(options = {})
        {:name => "ign", :id => stream.send("ign_id"), :data => source}
      end

    end

  end

end