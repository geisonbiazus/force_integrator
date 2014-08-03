require 'spec_helper'

describe ForceIntegrator::Authenticator do 

	let(:client_id) { 'my_super_client_id' }
	let(:client_secret) { 'this_is_secret' }
	let(:username) { "that_is_my_name" }
	let(:password) { "dont_tell_anyone" }
	let(:password_secret) { "do_I_have_to_tell_you_that?" }

	before :each do		

		expect_any_instance_of(Databasedotcom::Client).to receive(:authenticate).with(
			username: username, password: "#{password}#{password_secret}"
		)

		@authenticator = ForceIntegrator::Authenticator.new
		@authenticator.client_id = client_id
		@authenticator.client_secret = client_secret
		@authenticator.username = username
		@authenticator.password = password
		@authenticator.password_secret = password_secret		
		@client = @authenticator.authenticate
	end

	it "should return an authenticated Databasedotcom client" do
		expect(@client.client_id).to eq(client_id)
		expect(@client.client_secret).to eq(client_secret)
	end

	it "should store the materialized models on ForceIntegrator::Models module" do
		expect(@client.sobject_module).to eq(ForceIntegrator::Models) 
	end

	it "should return the client if already authenticated" do
		@client = @authenticator.authenticate

		expect_any_instance_of(Databasedotcom::Client).not_to receive(:authenticate)

		expect(@authenticator.authenticate).to be(@client)
	end
	
end