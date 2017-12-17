# Omniauth::Docusign

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/omniauth/docusign`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-docusign'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-docusign

## Usage

Docusign Oauth documentation: https://docs.docusign.com/esign/guide/authentication/oa2_auth_code.html

For a Rails application you'd now create an initializer config/initializers/omniauth.rb:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :docusign, 'docusign_integrator_key', 'docusign_secret_key', :site => 'https://account.docusign.com' 
end
# site defaults to: 'https://account.docusign.com', 
# for development or testing you can also use the demo site provided by docusign 'https://account-d.docusign.com'
```

After authentication success user will be redirected to the callback url with all the oauth and user information.
Default callback path is: `/auth/docusign/callback`

Docsign support token refresh feature. Example code.
```ruby
strategy = OmniAuth::Strategies::Docusign.new(
      nil,
      docusign_integrator_key,
      docusign_secret_key,
    )
new_token = strategy.refresh_token(
            current_docusign_token, docusign_refresh_token
          )    
```  

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/puneet-sutar/omniauth-docusign.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
