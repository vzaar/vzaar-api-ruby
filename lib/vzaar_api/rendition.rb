module VzaarApi
  class Rendition < Abstract

    ATTR_READERS = [:audio_bitrate_kbps, :audio_channels,
                    :audio_sample_rate, :bitrate_kbps,
                    :encoding_preset_id, :error_message,
                    :frame_rate, :height, :id, :keyframe,
                    :name, :output_format, :profile, :size_in_bytes,
                    :source_as_rendition, :state, :video_codec, :width,
                    :created_at, :updated_at].freeze

    prepend Lib::HasAttributes
    include Lib::HasCollectionBuilder

  end
end
