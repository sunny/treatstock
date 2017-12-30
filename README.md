# Treatstock

Ruby gem to send 3D files to the Treastock API.

## Installation

Add these lines to your application's Gemfile:

```ruby
# Send 3D files to the Treastock API.
gem "treatstock", git: "https://github.com/sunny/treatstock"
```

And then execute:

    $ bundle

## Usage

```rb
client = Treatstock.new(private_key: "your-private-key")
result = client.create_printable_pack(
  affiliate_price: 12,
  affiliate_currency: "USD",
  files: ["http://example.com/file.stl"],
)
result["redir"]
# => "https://sandbox.treatstock.com/api/v2/printable-packs?packPublicToken=…"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

## Release

To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/sunny/treatstock. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Treatstock project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/sunny/treatstock/blob/master/CODE_OF_CONDUCT.md).
