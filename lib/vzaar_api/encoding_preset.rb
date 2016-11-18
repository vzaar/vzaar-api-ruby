module VzaarApi
  class EncodingPreset

    include Lib::HasResourceUrl

    ENDPOINT = 'encoding_presets'

    attr_reader :id, :name, :description, :output_format, :bitrate_kbps,
      :long_dimension, :video_codec, :profile, :frame_rate, :keyframe, :audio_bitrate_kbps,
      :audio_channels, :audio_sample_rate, :max_bitrate_kbps, :keyframe_period,
      :created_at, :updated_at

    def initialize(attrs = {})
      @id = attrs[:id]
      @name = attrs[:name]
      @description = attrs[:description]
      @output_format = attrs[:output_format]
      @bitrate_kbps = attrs[:bitrate_kbps]
      @long_dimension = attrs[:long_dimension]
      @video_codec = attrs[:video_codec]
      @profile = attrs[:profile]
      @frame_rate = attrs[:frame_rate]
      @keyframe = attrs[:keyframe]
      @audio_bitrate_kbps = attrs[:audio_bitrate_kbps]
      @audio_channels = attrs[:audio_channels]
      @audio_sample_rate = attrs[:audio_sample_rate]
      @max_bitrate_kbps = attrs[:max_bitrate_kbps]
      @keyframe_period = attrs[:keyframe_period]
      @created_at = attrs[:created_at]
      @updated_at = attrs[:updated_at]
    end

    def self.build(data = [])
      Array(data).map { |attrs| new attrs }
    end

    def self.find(encoding_preset_id)
      url = resource_url(encoding_preset_id)
      response = Api.new.get(url)
      new response.data
    end

    def self.each(query = {}, &block)
      paginate(query).each(&block)
    end

    def self.paginate(query = {})
      args = query.merge({ resource_url: resource_url, resource_class: self })
      PagedResource.new(args)
    end

  end
end
