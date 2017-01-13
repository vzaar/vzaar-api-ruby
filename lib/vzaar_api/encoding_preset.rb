module VzaarApi
  class EncodingPreset < Abstract

    ENDPOINT = 'encoding_presets'

    ATTR_READERS = [:id, :name, :description, :output_format,
                    :bitrate_kbps, :long_dimension, :video_codec,
                    :profile, :frame_rate_upper_threshold, :keyframe_upper_threshold,
                    :audio_bitrate_kbps, :audio_channels, :audio_sample_rate,
                    :max_bitrate_kbps, :created_at, :updated_at].freeze

    prepend Lib::HasAttributes
    include Lib::HasCollectionBuilder
    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::WillPaginate

  end
end
