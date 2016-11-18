module VzaarApi
  class LegacyRendition

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

    def self.build(data = [])
      Array(data).map { |attrs| new attrs }
    end

  end
end
