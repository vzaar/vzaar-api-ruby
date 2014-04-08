module Vzaar
  class User < Response::Base

    attr_reader :version, :author_id, :author_name, :author_url,
      :author_account, :author_account_title, :created_at,
      :video_count, :play_count, :max_file_size

    alias_method :id, :author_id
    alias_method :name, :author_name
    alias_method :url, :author_url
    alias_method :account_type_id, :author_account
    alias_method :account_type_name, :author_account_title

    def initialize(xml)
      super(xml)
      @version = extract_text('//user/version')
      @author_id = extract_text('//user/author_id')
      @author_name = extract_text('//user/author_name')
      @author_url = extract_text('//user/author_url')
      @author_account = extract_text('//user/author_account')
      @author_account_title = extract_text('//user/author_account_title')
      @created_at = extract_text('//user/created_at')
      @video_count = extract_text('//user/video_count')
      @play_count = extract_text('//user/play_count')
      @max_file_size = extract_text('//user/max_file_size')
    end

  end
end
