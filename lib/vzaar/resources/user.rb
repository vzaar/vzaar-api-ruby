module Vzaar
  module Resource
    class User < Base
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

      def bandwidth
        @bandwidth ||= doc.xpath("//bandwidth/period").map do |e|
          attrs = e.attributes
          { year: attrs["year"].text, month: attrs["month"].text, value: e.text.to_i }
        end
      end
    end
  end
end
