module Vzaar
  class Api < Struct.new(:options)
    def conn
      @conn ||= Connection.new(options)
    end

    def whoami(opts={})
      Request::WhoAmI.new(conn, opts).execute
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
      upload_resource do |signature|
        uploader = Uploader.new(conn, signature.resource, opts)
        uploader.upload do |u|
          process_audio(u.processing_params)
        end
      end
    end

    def upload_video(opts={})
      upload_resource do |signature|
        uploader = Uploader.new(conn, signature.resource, opts)
        uploader.upload do |u|
          process_video(u.processing_params)
        end
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

    def link_upload(url, opts={})
      upload_resource do |signature|
        _opts = opts.merge(guid: signature.guid, key: sig.key, url: url)
        Request::LinkUpload.new(conn, _opts).execute
      end
    end

    def s3_upload(file_path)
      upload_resource do |signature|
        uploader = Uploader.new(conn, signature, path: file_path)
        uploader.upload
        uploader.processing_params
      end
    end

    private

    def upload_resource(&fn)
      sig = signature
      sig.status_code == 200 ? yield(sig) : sig
    end
  end
end
