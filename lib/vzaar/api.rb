module Vzaar
  class Api

    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def whoami(opts={})
      Request::WhoAmI.new(connection, opts).execute
    end

    def account_type(account_type_id, opts={})
      _opts = opts.merge(account_type_id: account_type_id)
      Request::AccountType.new(connection, _opts).execute
    end

    def user_details(login, opts={})
      Request::UserDetails.new(connection, opts.merge(login: login)).execute
    end

    def video_details(video_id, opts={})
      Request::Video.new(connection, opts.merge(video_id: video_id)).execute
    end

    def video_list(login, opts={})
      Request::VideoList.new(connection, opts.merge(login: login)).execute
    end

    def videos(opts={})
      video_list(connection.login, { authenticated: true, page: opts[:page] })
    end

    def delete_video(video_id, opts={})
      Request::DeleteVideo.new(connection, opts.merge(video_id: video_id)).execute
    end

    def edit_video(video_id, opts={})
      Request::EditVideo.new(connection, opts.merge(video_id: video_id)).execute
    end

    def signature(opts={})
      Request::Signature.new(connection, opts).execute
    end

    def upload_video(path, options = {})
      sig = SignatureExtractor.new(signature, options[:format]).extract
      if upload_to_s3(path, sig)
        process_video :guid => sig[:guid], :title => options[:title],
          :description => options[:description], :profile => options[:profile],
          :transcoding => options[:transcoding]
      end
    end

    def process_video(opts={})
      Request::ProcessVideo.new(connection, opts).execute
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
