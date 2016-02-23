module Vzaar
  class Api < Struct.new(:options)
    def conn
      @conn ||= Connection.new(options)
    end

    def whoami(opts={})
      resource = Request::WhoAmI.new(conn, opts).execute
      resource.login
    end

    def account_type(account_type_id, opts={})
      _opts = opts.merge(account_type_id: account_type_id)
      Request::AccountType.new(conn, _opts).execute
    end

    def user_details(login, opts={})
      Request::UserDetails.new(conn, opts.merge(login: login)).execute
    end

    def video_details(video_id, opts={})
      Request::VideoDetails.new(conn, opts.merge(video_id: video_id)).execute
    end

    def video_list(login, opts={})
      Request::VideoList.new(conn, opts.merge(login: login)).execute
    end

    def videos(opts={})
      video_list(conn.login, opts.merge({ authenticated: true }))
    end

    def delete_video(video_id, opts={})
      Request::DeleteVideo.new(conn, opts.merge(video_id: video_id)).execute
    end

    def edit_video(video_id, opts={})
      Request::EditVideo.new(conn, opts.merge(video_id: video_id)).execute
    end

    def signature(opts={})
      Request::Signature.new(conn, opts).execute
    end

    def process_video(opts={})
      Request::ProcessVideo.new(conn, opts).execute
    end

    def process_audio(opts={})
      Request::ProcessAudio.new(conn, opts).execute
    end

    def upload_audio(opts={})
      uploader = Uploader.new(conn, signature(opts), opts)
      uploader.upload do |u|
        process_audio(u.processing_params)
      end
    end

    def upload_video(opts={})
      sig = signature(opts)
      uploader = Uploader.new(conn, sig, opts)
      uploader.upload do |u|
        process_video(u.processing_params)
      end
    end

    def add_subtitle(video_id, opts={})
      Request::AddSubtitle.new(conn, opts.merge(video_id: video_id)).execute
    end

    def upload_thumbnail(video_id, opts={})
      Request::UploadThumbnail.new(conn, opts.merge(video_id: video_id)).execute
    end

    def generate_thumbnail(video_id, opts={})
      Request::GenerateThumbnail.new(conn, opts.merge(video_id: video_id)).execute
    end

    # TODO: remove
    def link_upload(url, opts={})
      sig = signature
      _opts = opts.merge({ guid: sig.guid, key: sig.key, url: url })
      Request::LinkUpload.new(conn, _opts).execute
    end

    # TODO: remove
    def s3_upload(file_path)
      uploader = Uploader.new(conn, signature, path: file_path)
      uploader.upload
      uploader.processing_params
    end
  end
end
