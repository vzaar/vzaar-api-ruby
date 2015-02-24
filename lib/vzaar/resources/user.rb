module Vzaar
  module Resource
    class User < Base
      class Bandwidth
        attr_reader :year, :month, :value
        def initialize(year, month, value)
          @year = year.to_i
          @month = month.to_i
          @value = value.to_i
        end
      end

      class BandwidthCollection < Vzaar::Resource::Base::Collection
        def build
          xml_doc.xpath(node).map do |xml|
            xml_attrs = xml.attributes
            year = xml_attrs["year"].text
            month = xml_attrs["month"].text
            val =  xml.text.to_i

            Bandwidth.new(year, month, val)
          end
        end
      end

      root_node "//user"

      attribute :created_at, type: Time
      attribute :max_file_size, type: Integer
      attribute :account_type_id, field: :author_account, type: Integer
      attribute :account_type_name, field: :author_account_title
      attribute :name, field: :author_name
      attribute :url, field: :author_url
      attribute :id, field: :author_id, type: Integer
      attribute :video_count, type: Integer
      attribute :play_count, type: Integer
      attribute :videos_total_size, type: Integer
      attribute :bandwidth_this_month, type: Integer

      attribute :bandwidth,
                type: BandwidthCollection,
                node: "bandwidth/period",
                class: Bandwidth
    end
  end
end
