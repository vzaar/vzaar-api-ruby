module VzaarApi
  class LegacyRendition

    include Lib::HasCollectionBuilder

    attr_reader :id, :type, :width, :height, :bitrate, :status, :created_at, :updated_at

    def initialize(attrs = {})
      @id = attrs[:id]
      @type = attrs[:type]
      @width = attrs[:width]
      @height = attrs[:height]
      @bitrate = attrs[:bitrate]
      @status = attrs[:status]
      @created_at = attrs[:created_at]
      @updated_at = attrs[:updated_at]
    end

    def to_hash
      {
        id: self.id,
        type: self.type,
        width: self.width,
        height: self.height,
        bitrate: self.bitrate,
        status: self.status,
        created_at: self.created_at,
        updated_at: self.updated_at
      }
    end

  end
end
