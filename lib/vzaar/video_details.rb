module Vzaar
  class VideoDetails < Response::Base

    attr_reader :id, :type, :version, :title, :description, :author_name,
      :author_url, :author_account, :provider_name, :provider_url,
      :video_url, :thumbnail_url, :thumbnail_width, :thumbnail_height,
      :framegrab_url, :framegrab_width, :framegrab_height, :html, :height,
      :width, :duration, :video_status_id, :video_status_description,
      :play_count

    alias_method :user_name, :author_name
    alias_method :user_url, :author_url
    alias_method :user_account_type_id, :author_account

    def initialize(video_id, xml)
      super(xml)
      @id = video_id
      @type = extract_text('//oembed/type')
      @version = extract_text('//oembed/version')
      @title = extract_text('//oembed/title')
      @description = extract_text('//oembed/description')
      @author_name = extract_text('//oembed/author_name')
      @author_url = extract_text('//oembed/author_url')
      @author_account = extract_text('//oembed/author_account')
      @provider_name = extract_text('//oembed/provider_name')
      @provider_url = extract_text('//oembed/provider_url')
      @video_url = extract_text('//oembed/video_url')
      @thumbnail_url = extract_text('//oembed/thumbnail_url')
      @thumbnail_width = extract_text('//oembed/thumbnail_width')
      @thumbnail_height = extract_text('//oembed/thumbnail_height')
      @framegrab_url = extract_text('//oembed/framegrab_url')
      @framegrab_width = extract_text('//oembed/framegrab_width')
      @framegrab_height = extract_text('//oembed/framegrab_height')
      @html = extract_text('//oembed/html')
      @height = extract_text('//oembed/height')
      @width = extract_text('//oembed/width')
      @duration = extract_text('//oembed/duration')
      @video_status_id = extract_text('//oembed/video_status_id')
      @video_status_description = extract_text('//oembed/video_status_description')
      @play_count = extract_text('//oembed/play_count')
    end

  end
end
