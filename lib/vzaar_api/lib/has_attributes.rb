module VzaarApi
  module Lib
    module HasAttributes

      def self.prepended(klass)
        klass::ATTR_READERS.each do |attr|
          klass.send :attr_reader, attr
        end

        unless defined? klass::ATTR_ACCESSORS
          klass.const_set 'ATTR_ACCESSORS', [].freeze
        end

        klass::ATTR_ACCESSORS.each do |attr|
          klass.send :attr_accessor, attr

          klass.send(:define_method, "#{attr}=") do |val|
            if self.changes[attr]
              self.changes[attr][1] = val
            else
              self.changes[attr] = [self.send(attr), val]
            end
            val
          end
        end
      end

      def initialize(attrs = {})
        self.class::ATTR_READERS.each do |attr|
          instance_variable_set("@#{attr}", attrs[attr])
        end
        self.class::ATTR_ACCESSORS.each do |attr|
          instance_variable_set("@#{attr}", attrs[attr])
        end
        super
      end

      private

      def update_from_attributes(attrs = {})
        attrs.each do |attr, val|
          instance_variable_set("@#{attr}", attrs[attr])
        end
        super
      end

    end
  end
end
