# vzaar API

![vzaar Logo](https://raw.github.com/vzaar/vzaar-api-ruby/master/vzaar.png)

By [vzaar](http://vzaar.com)

[![Build Status](https://secure.travis-ci.org/vzaar/vzaar-api-ruby.png)](http://travis-ci.org/vzaar/vzaar-api-ruby) [![Code Climate](https://codeclimate.com/github/vzaar/vzaar-api-ruby.png)](https://codeclimate.com/github/vzaar/vzaar-api-ruby)

vzaar's Ruby client for interacting with version 2 of the [vzaar API](https://vzaar.readme.io/docs).

## Requirements

Ruby 2.2+

## Installation

```
gem install vzaar --version
```


## Backwards compatability

Versions 1 and 2 of the vzaar API are incompatable with each other. The same applies to the API SDKs. Some functionality available in the version 1 SDK has been deprecated in version 2 and will not be implemented. The version 2 API also has a different authentication mechanism so your existing API key will not work with version 2 SDKs.

To ease migration to the version 2 SDK, it is possible to use both versions without any conflicts.

```
Vzaar       # <= this is version 1
VzaarApi    # <= this is version 2
```

## Usage

Configure your API credentials:

```
VzaarApi.auth_token = '<your-auth-token>'
VzaarApi.client_id  = '<your-client-id>'
```

Usage instructions and examples are available on [vzaar's documentation site](https://vzaar.readme.io).


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the [MIT License](http://www.opensource.org/licenses/MIT).
