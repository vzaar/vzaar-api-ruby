module VzaarApi
  module Lib
    module ActiveObject

      module Find
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def find(id)
            response = Api.new.get(resource_url(id))
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
            response = Api.new.post(resource_url, attrs)
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
            response = Api.new.patch(resource_url(id), to_hash)
            update_from_attributes response.data
            true
          end
        end
      end

      module Delete
        def self.included(base)
          base.include(InstanceMethods)
        end

        module InstanceMethods
          def delete
            Api.new.delete(resource_url(id))
            true
          end
        end
      end

    end
  end
end
