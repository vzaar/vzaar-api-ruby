module Vzaar
  class Api

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def whoami
      url = '/api/test/whoami'
      connection.using_authorised_connection(Http::GET, url) do |xml|
        return WhoAmI.new(xml).login
      end
    end

    def account_type(account_type_id)
      url = "/api/accounts/#{account_type_id}.xml"
      connection.using_public_connection(Http::GET, url) do |xml|
        return AccountType.new(xml)
      end
    end

    def user_details(login, authenticated)
      url = "/api/users/#{login}.xml"
      connection.using_connection(authenticated, Http::GET, url) do |xml|
        return User.new(xml)
      end
    end

    def video_details(video_id, authenticated)
      url = "/api/videos/#{video_id}.xml"
      connection.using_connection(authenticated, Http::GET, url) do |xml|
        return VideoDetails.new(video_id, xml)
      end
    end

    def video_list(login, authenticated = false, page = 1)
      url = "/api/#{login}/videos.xml?page=#{page}"
      connection.using_connection(authenticated, Http::GET, url) do |xml|
        return VideoCollection.new(xml)
      end
    end

    def videos(page = 1)
      video_list(connection.login, true, page)
    end

    def delete_video(video_id)
      url = "/api/videos/#{video_id}.xml"
      connection.using_authorised_connection Http::DELETE, url
    end

    def edit_video(video_id, options = {})
      url = "/api/videos/#{video_id}.xml"
      request = Request::EditVideo.new(options)
      connection.using_authorised_connection Http::PUT, url, request.xml
    end

    def signature(options = {})
      request = Request::Signature.new('/api/videos/signature', options)
      connection.using_authorised_connection Http::GET, request.url do |xml|
        return Signature.new xml
      end
    end

    def upload_video(path, options = {})
      sig = signature
      if upload_to_s3(path, sig)
        process_video :guid => sig.guid, :title => options[:title],
          :description => options[:description], :profile => options[:profile],
          :transcoding => options[:transcoding]
      end
    end

    def process_video(options = {})
      url = '/api/videos'
      request = Request::ProcessVideo.new(options)
      connection.using_authorised_connection Http::POST, url, request.xml do |xml|
        return ProcessVideo.new(xml).video_id
      end
    end

    private

    def upload_to_s3(file_path, signature)
      uploader = S3Uploader.new(file_path, signature)
      uploader.upload
    rescue Exception => e
      VzaarError.generate :unknown, e.message
    end

  end
end
