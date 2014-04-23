# vzaar  [![Build Status](https://secure.travis-ci.org/vzaar/vzaar-api-ruby.png)](http://travis-ci.org/vzaar/vzaar-api-ruby) [![Code Climate](https://codeclimate.com/github/vzaar/vzaar-api-ruby.png)](https://codeclimate.com/github/vzaar/vzaar-api-ruby)

A Ruby gem for the vzaar API.

Note: This version is a beta release.

### Installation

Add this line to your application's Gemfile:

    gem 'vzaar', :git => "git@github.com:vzaar/vzaar-api-ruby.git", :branch => 'master'

And then execute:

    $ bundle


### Usage

```ruby
conn = Vzaar::Connection.new(:application_token => "API token", :login => "vzaar login")
api = Vzaar::Api.new(conn)
```

If your login and API token are correct, you should be able to fetch your login by calling:
```ruby
api.whoami
=> "VZAAR LOGIN"
```

### Endpoints:

Fetching account's type details:
```ruby
api.account_type(account_type_id, options)
```

Fetching user's details:
```ruby
api.user_details("user login", options)
```

Getting details from public video:
```ruby
api.video_details(video_id, options)
```

Getting details from private video (authentication required):
```ruby
api.video_details(video_id, authenticated: true)
```

Fetching videos for a given user:
```ruby
api.video_details("user login", options)
```

Fetching videos for authenticated user (authentication required):
```ruby
api.videos
```

Removing video from vzaar: (authentication required)
```ruby
api.delete(video_id)
```

Updating existing video (authentication required):
```ruby
api.edit_video(video_id, options)

# options are: title, description, private and seo_url
```

Uploading new video to vzaar (authentication required):
```ruby
api.upload_video(options)

# options are: path, url, title, description, profile, transcoding, replace_id,
# width and bitrate
#
# e.g api.upload(path: "./path/to/video.mp4", title: "my video")
#
# For link upload use url param:
# api.upload(url: "http://example.com/video.mp4", title: "my video")
```

Getting guid and aws signature (authentication required):
```ruby
api.signature
```

### Previous versions of vzaar gem

This version is not backwards compatible with any of the previous versions of vzaar gem (0.2.x series)
0.2.x series is no longer maintained.


### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
