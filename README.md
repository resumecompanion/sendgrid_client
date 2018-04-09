# SendgridClient


Sendgrid ruby client which wraper the [SendGrid v3 API ](https://sendgrid.com/docs/API_Reference/api_v3.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sendgrid_client', git: 'git@github.com:resumecompanion/sendgrid_client.git'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sendgrid_client
require ruby version `>= 1.9.3`

## Usage

### Config the credential
```ruby
SendgridClient.configure do |config|
  config.username = 'USER_NAME'
  config.password = 'PASSWORD'
  config.test_mode = false # default false
end
```
or
```ruby
SendgridClient.configuration.username = 'USER_NAME'
SendgridClient.configuration.password = 'PASSWORD'
```
## Development
### Create & update recipient to contact list
params can be array of hash, create mutiple recipients at one time.
```ruby
params = { email: 'test@test.com',
           first_name: 'firstname',
           last_name: 'lastname',  
           YOUR_CUSTOM_FIELD: 'xxxx'
         }

SendgridClient::Contact.update(params)
```
### search recipient from contact list
```ruby
SendgridClient::Contact.search('test@test.com')
```
### Delete recipient from contact list
```ruby
SendgridClient::Contact.delete('test@test.com')
```

## Test
Set `test_mode` as true can pervent send request in test environment

```ruby
SendgridClient.configure do |config|
  config.test_mode = true # default false
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
