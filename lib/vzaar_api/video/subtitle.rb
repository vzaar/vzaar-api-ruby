module VzaarApi
  class Video
    class Subtitle < Abstract
      ENDPOINT = Proc.new do |video_id, subtitle_id|
        File.join 'videos', video_id.to_s, 'subtitles', subtitle_id.to_s
      end

      ATTR_READERS = [:id,
                      :code,
                      :title,
                      :language,
                      :created_at,
                      :updated_at
                     ].freeze

      ATTR_ACCESSORS = [:code].freeze

      prepend Lib::HasAttributes
      include Lib::HasResourceUrl
      include Lib::ActiveObject::Create
      include Lib::ActiveObject::Save
      include Lib::ActiveObject::Delete
      include Lib::WillPaginate

      def initialize(attrs = {})
        @scope_id = attrs.delete(:scope_id)
      end

      def self.paginate(video_id, query = {})
        super query.merge(scope_id: video_id)
      end

      def self.create(video_id, attrs = {})
        VzaarApi::Strategy::Subtitle::Create.new(video_id, attrs, self).execute
      end
    end
  end
end
