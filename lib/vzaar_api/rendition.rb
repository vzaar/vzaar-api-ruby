module VzaarApi
  class Rendition

    include Lib::HasCollectionBuilder

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

    def to_hash
      {
        id: self.id,
        encoding_preset_id: self.encoding_preset_id,
        state: self.state,
        source_as_rendition: self.source_as_rendition,
        name: self.name,
        output_format: self.output_format,
        bitrate_kbps: self.bitrate_kbps,
        width: self.width,
        height: self.height,
        video_codec: self.video_codec,
        profile: self.profile,
        frame_rate: self.frame_rate,
        keyframe: self.keyframe,
        audio_bitrate_kbps: self.audio_bitrate_kbps,
        audio_channels: self.audio_channels,
        audio_sample_rate: self.audio_sample_rate,
        size_in_bytes: self.size_in_bytes,
        error_message: self.error_message,
        created_at: self.created_at,
        updated_at: self.updated_at
      }
    end

  end
end
