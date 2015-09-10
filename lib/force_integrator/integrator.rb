class ForceIntegrator::Integrator

  def initialize(contact)
    @contact = contact
  end

  def save
    contact = contact_reference

    @contact.class.field_mapper.fields.each do |field|
      contact[field.sf_field] = @contact.send(field.model_field)
    end

    user_class = @client.materialize('User')
    contact['OwnerId'] = user_class.find_by_Email(@contact.sf_authenticator.username).Id

    contact.save

    @contact.update_attribute(:salesforce_id, contact.Id)
  end

  def destroy    
    contact = contact_reference
    contact.delete
  end

  private

  def contact_reference
    authenticate
    contact_class = @client.materialize('Contact')
    @contact.salesforce_id.blank? ? contact_class.new : contact_class.find(@contact.salesforce_id)
  end

  def authenticate
    @client = @contact.sf_authenticator.authenticate
  end

end