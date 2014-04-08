module Vzaar
  class Video < Response::XML

    attr_reader :version, :id, :status, :status_id, :title, :description,
      :created_at, :url, :thumbnail_url, :play_count, :author_name,
      :author_url, :author_account, :video_count, :duration, :height, :width

    alias_method :user_name, :author_name
    alias_method :user_url, :author_url
    alias_method :user_account_type_id, :author_account
    alias_method :user_video_count, :video_count

    def initialize(xml)
      super(xml)
      @version = extract_text('//video/version')
      @id = extract_text('//video/id')
      @status = extract_text('//video/status')
      @status_id = extract_text('//video/status_id')
      @title = extract_text('//video/title')
      @description = extract_text('//video/description')
      @created_at = extract_text('//video/created_at')
      @url = extract_text('//video/url')
      @thumbnail_url = extract_text('//video/thumbnail_url')
      @play_count = extract_text('//video/play_count')
      @author_name = extract_text('//video/user/author_name')
      @author_url = extract_text('//video/user/author_url')
      @author_account = extract_text('//video/user/author_account')
      @video_count = extract_text('//video/user/video_count')
      @duration = extract_text('//video/duration')
      @height = extract_text('//video/height')
      @width = extract_text('//video/width')
    end

  end
end
