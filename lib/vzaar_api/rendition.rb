module VzaarApi
  class Rendition

    attr_reader :audio_bitrate_kbps, :audio_channels, :audio_sample_rate,
      :bitrate_kbps, :encoding_preset_id, :error_message, :frame_rate,
      :height, :id, :keyframe, :name, :output_format, :profile, :size_in_bytes,
      :source_as_rendition, :state, :video_codec, :width,
      :created_at, :updated_at

    def initialize(attrs = {})
      @id = attrs[:id]
      @encoding_preset_id = attrs[:encoding_preset_id]
      @state = attrs[:state]
      @source_as_rendition = attrs[:source_as_rendition]
      @name = attrs[:name]
      @output_format = attrs[:output_format]
      @bitrate_kbps = attrs[:bitrate_kbps]
      @width = attrs[:width]
      @height = attrs[:height]
      @video_codec = attrs[:video_codec]
      @profile = attrs[:profile]
      @frame_rate = attrs[:frame_rate]
      @keyframe = attrs[:keyframe]
      @audio_bitrate_kbps = attrs[:audio_bitrate_kbps]
      @audio_channels = attrs[:audio_channels]
      @audio_sample_rate = attrs[:audio_sample_rate]
      @size_in_bytes = attrs[:size_in_bytes]
      @error_message = attrs[:error_message]
      @created_at = attrs[:created_at]
      @updated_at = attrs[:updated_at]
    end

    def self.build(data = [])
      Array(data).map { |attrs| new attrs }
    end

  end
end
