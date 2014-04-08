require 'forwardable'

module Vzaar
  class Base

    extend Forwardable
    def_delegators :@connection, :application_token, :force_http, :login, :server

    DEFAULTS = {
      application_token: '',
      force_http: false,
      login: '',
      server: 'vzaar.com'
    }.freeze

    attr_reader :api, :connection

    def initialize(user_options = {})
      options = DEFAULTS.merge(user_options)
      @connection = Connection.new(options)
      @api = Api.new @connection
    end

    def whoami
      api.whoami
    end

    def account_type(account_type_id)
      api.account_type account_type_id
    end

    def user_details(login, authenticated = false)
      api.user_details login, authenticated
    end

    def video_details(video_id, authenticated = false)
      api.video_details video_id, authenticated
    end

    def video_list(login, authenticated = false, page = 1)
      api.video_list login, authenticated, page
    end

    def videos(page = 1)
      video_list(login, true, page)
    end

    def delete_video(video_id)
      api.delete_video video_id
    end

    def edit_video(video_id, options = {})
      api.edit_video video_id, options
    end

    def signature(options = {})
      api.signature options
    end

    def upload_video(path, options = {})
      api.upload_video path, options
    end

  end
end
