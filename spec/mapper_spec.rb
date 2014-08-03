require 'spec_helper'

describe ForceIntegrator::Mapper do

	before :each do

		@mapped_class = Class.new do
			include ForceIntegrator::Mapper
		end

	end

	it "should store the authentication params" do
		mapped = @mapped_class.new
		
		mapped.sf_authenticator do |auth|
			auth.client_id = 'id'
		end

		expect(mapped.sf_authenticator).to be_a(ForceIntegrator::Authenticator)
		expect(mapped.sf_authenticator.client_id).to eq('id')
	end

	it "should maps the class attributes with the salesforce attributes" do
		@mapped_class.map_fields do |mapper|
			mapper.map('Name', :name)
		end

		expect(@mapped_class.field_mapper).to be_a(ForceIntegrator::FieldMapper)
		expect(@mapped_class.field_mapper.fields.first.sf_field).to eq('Name')
		expect(@mapped_class.field_mapper.fields.first.model_field).to eq(:name)

	end

end
