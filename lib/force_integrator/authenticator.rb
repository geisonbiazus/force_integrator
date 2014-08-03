class ForceIntegrator::Authenticator
	attr_accessor :client_id, :client_secret, :username, :password, :password_secret

	def authenticate
		# return @client if @client
		@client = Databasedotcom::Client.new({
			:client_id => client_id, 
			:client_secret => client_secret
		})
		@client.sobject_module = ForceIntegrator::Models

		@client.authenticate :username => username, :password => "#{@password}#{@password_secret}"
		@client
	end

end