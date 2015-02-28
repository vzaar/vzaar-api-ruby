# vzaar  [![Build Status](https://secure.travis-ci.org/vzaar/vzaar-api-ruby.png)](http://travis-ci.org/vzaar/vzaar-api-ruby) [![Code Climate](https://codeclimate.com/github/vzaar/vzaar-api-ruby.png)](https://codeclimate.com/github/vzaar/vzaar-api-ruby)

A Ruby gem for the vzaar API.

---

>vzaar is the go to video hosting platform for business. Affordable, customizable and secure. Leverage the power of online video and enable commerce with vzaar. For more details and signup please visit [http://vzaar.com](http://vzaar.com)

----

### Installation

Add this line to your application's Gemfile:

    gem 'vzaar'

And then execute:

    $ bundle


### Usage

```ruby
api = Vzaar::Api.new(application_token: "API token", login: "vzaar login")
```

If your login and API token are correct, you should be able to fetch your login by calling:
```ruby
res = api.whoami
res.resource.login
=> "VZAAR LOGIN"
```

### Endpoints:

Fetching account's type details:
```ruby
account_type = api.account_type(1, options).resource
account_type.title
=> "Free"
```

Fetching user's details:
```ruby
user = api.user_details("user_login", options).resource
user.name
=> "user_login"
```

Getting details from public video:
```ruby
video = api.video_details(video_id, options).resource
video.title
=> "My video"
```

Getting details from private video (authentication required):
```ruby
video = api.video_details(video_id, authenticated: true).resource
video.title
=> "My video"
```

Fetching videos for a given user:
```ruby
videos = api.video_list("user login", options).resource
videos.last.title
=> "My video"
```

Fetching videos for authenticated user (authentication required):
```ruby
videos = api.videos.resource
videos.last.title
=> "My video"
```

Removing video from vzaar: (authentication required)
```ruby
deleted_video = api.delete_video(video_id).resource
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
# video = api.upload_video(path: "./path/to/video.mp4", title: "my video").resource
# video.resource.status
# => "Processing not complete"
#
# For link upload use url param:
# video = api.upload_video(url: "http://example.com/video.mp4", title: "my video").resource
# video.id
# => 12345
```

Uploading new thumbnail for video (authentication required):
```ruby
api.upload_thumbnail(video_id, options)

# api.upload_thumbnail(123456, path: "/path/to/image.jpg")
```

Generating new thumbnail based on given time value (authentication required):
```ruby
api.generate_thumbnail(video_id, options)

# api.generate_thumbnail(123456, time: 3)
```

Adding subtitle to the video (authentication required):
```ruby
api.add_subtitle(video_id, options)

# api.add_subtitle(123456, body: "1\n00:00:17,440 --> 00:01:20,375\n ......", language: "en")
```

Getting guid and aws signature (authentication required):
```ruby
sig = api.signature.resource
sig.guid
=> "vz944cd744a63748f3868b2766e5e9c3ab"
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
