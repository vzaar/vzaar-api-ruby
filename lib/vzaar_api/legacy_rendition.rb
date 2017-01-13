module VzaarApi
  class LegacyRendition < Abstract

    ATTR_READERS = [:id, :type, :width, :height, :bitrate,
                    :status, :created_at, :updated_at].freeze

    prepend Lib::HasAttributes
    include Lib::HasCollectionBuilder

  end
end
