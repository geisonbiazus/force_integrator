class ForceIntegrator::Integrator

	def initialize(contact)
		@contact = contact
	end

	def save
		authenticate
		contact_class = @client.materialize('Contact')
		contact = @contact.salesforce_id.blank? ? contact_class.new : contact_class.find(@contact.salesforce_id)

		@contact.class.field_mapper.fields.each do |field|
			contact[field.sf_field] = @contact.send(field.model_field)
		end

		user_class = @client.materialize('User')
		contact['OwnerId'] = user_class.find_by_Email(@contact.sf_authenticator.username).Id

		contact.save
	end

	def destroy
		authenticate
		contact_class = @client.materialize('Contact')
		# binding.pry		
		contact = contact_class.find(@contact.salesforce_id)
		contact.delete
	end

	private

	def authenticate
		@client = @contact.sf_authenticator.authenticate
	end

end