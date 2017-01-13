module VzaarApi
  module Lib
    module ActiveObject

      module Find
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def find(id)
            response = Lib::Api.new.get(resource_url(id))
            new response.data
          end
        end
      end

      module Create
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def create(attrs)
            response = Lib::Api.new.post(resource_url, attrs)
            new response.data
          end
        end
      end

      module Save
        def self.included(base)
          base.include(InstanceMethods)
        end

        module InstanceMethods
          def save
            response = Lib::Api.new.patch(resource_url(id), changed_attributes)
            update_from_attributes response.data
            true
          end

          def changed?
            !changes.empty?
          end

          def changed
            changes.keys
          end

          def changed_attributes
            {}.tap do |result|
              changes.each do |attr, vals|
                result[attr] = vals[1]
              end
            end
          end

          def changes
            @changes ||= {}
          end

          def has_changed?(attr)
            changed.include? attr.to_sym
          end
        end
      end

      module Delete
        def self.included(base)
          base.include(InstanceMethods)
        end

        module InstanceMethods
          def delete
            Lib::Api.new.delete(resource_url(id))
            true
          end
        end
      end

    end
  end
end
