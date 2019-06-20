# Dragonfly::GoogleDataStore

A datastore for Dragonfly using Google Cloud Storage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dragonfly-google_data_store'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly-google_data_store

## Usage

First, create a service account on [Google Cloud Console](https://console.cloud.google.com/iam-admin/serviceaccounts/).
The easiest settings are:
* Select "Storage Administrator" as role
* Make sure to create a JSON private key

Configure the datastore as follows:

```ruby
Dragonfly.app.configure do
  datastore :google,
            project: 'project-id-here',
            bucket: 'bucket-name-here',
            keyfile: 'path/to/your/key/file.json',
            root_path: 'root/path'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dragonfly-google_data_store. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
