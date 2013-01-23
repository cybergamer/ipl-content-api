module Events
  module Data
    class Sanitizer < ActiveModel::MassAssignmentSecurity::Sanitizer

      delegate :process_removed_attributes, :to => :@target

      attr_accessor :target

      def initialize(target)
        @target = target
        super
      end

    end
  end
end