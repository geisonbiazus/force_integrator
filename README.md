# ForceIntegrator

Use this gem to integrate your Rails app with Salesforce

## Installation

Add this line to your application's Gemfile:

    gem 'force_integrator', git: 'https://github.com/geisonbiazus/force_integrator.git'

And then execute:

    $ bundle

## Usage

In your model include the ForceIntegrator::Mapper module and them map your fields as following:

	class Contact < ActiveRecord::Base
	  include ForceIntegrator::Mapper
	
	  map_fields do |m|
	    m.map 'FirstName', :first_name
	    m.map 'LastName', :last_name
	    m.map 'Email', :email
	    m.map 'Phone', :phone
	  end
	
	  ...
	
	end

Then configure the salesforce authentication params

	@contact.sf_authenticator do |auth|
	  auth.client_id = "your salesforce client id"
	  auth.client_secret = "your salesforce client secret"
	  auth.username = "salesforce username"
	  auth.password = "salesforce password"
	  auth.password_secret = "salesforce password secret"
	end

The following methods are available:

	@contact.save_on_salesforce
	@contact.remove_from_salesforce

Be free to use then on ActiveRecord callbacks or using a background job gem like sidekiq

## Contributing

1. Fork it ( https://github.com/[my-github-username]/force_integrator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
