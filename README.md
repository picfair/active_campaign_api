# ActiveCampaignApi

There doesn't seem to be a ActiveCampaign SDK that works with
V3 of the API.  This gem is very lightweight attempt at filling
that gap.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_campaign_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_campaign_api

## Usage

### Initialize the client

    client = ActiveCampaignApi::Client.new(
      api_url: <http://Your-API-URL.api-us1.com/>,
      api_key: <Your-api-key>,
    )

### GET Contacts and look at the result

    # GET Contacts
    result = client.get('contacts')
    # => {"scoreValues"=>[], "contacts"=>[{...

    # Count the contacts
    result['contacts'].count
    # => 4

    # Look at their IDs
    result['contacts'].map{|c| c['id']}
    # => ["6", "1", "2", "15"]

### GET a contact by id

    # GET a specific contact
    result = client.get('contacts/1')
    # => {"contactAutomations"=>[], "contactLists"=>[], "deals"=>[], ...

    result.keys
    # => ["contactAutomations", "contactLists", "deals", "fieldValues", "geoIps", "accountContacts", "contact"]

    result['contact']['email']
    # => "hello@example.com"

### UPDATE a contact

    result = client.put('contacts/1', body: {contact: {email: 'hi@example.com'}})
    # => {"contact"=>{"cdate"=>"2021-05-10T09:20:37-05:00", "email"=>"hi@example.com",

    result = client.get('contacts/1')['contact']['email']


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/picfair/active_campaign_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
