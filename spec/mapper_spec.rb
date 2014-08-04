require 'spec_helper'

describe ForceIntegrator::Mapper do

	before :each do

		@mapped_class = Class.new do
			include ForceIntegrator::Mapper

			def id
				"id"
			end					
		end

		@mapped = @mapped_class.new
		allow(@mapped).to receive(:class).and_return(double('class', name: 'MappedClass'))
	end

	it "should store the authentication params" do
		@mapped.sf_authenticator do |auth|
			auth.client_id = 'id'
		end

		expect(@mapped.sf_authenticator).to be_a(ForceIntegrator::Authenticator)
		expect(@mapped.sf_authenticator.client_id).to eq('id')
	end

	it "should maps the class attributes with the salesforce attributes" do
		@mapped_class.map_fields do |mapper|
			mapper.map('Name', :name)
		end

		expect(@mapped_class.field_mapper).to be_a(ForceIntegrator::FieldMapper)
		expect(@mapped_class.field_mapper.fields.first.sf_field).to eq('Name')
		expect(@mapped_class.field_mapper.fields.first.model_field).to eq(:name)

	end

	it "should save on salesforce" do
		expect_any_instance_of(ForceIntegrator::Integrator).to receive(:save)
		@mapped.save_on_salesforce
	end

	it "should not save on salesforce twice on the same attempt" do
		@mapped.instance_variable_set("@saved", true)
		expect_any_instance_of(ForceIntegrator::Integrator).not_to receive(:save)		
		@mapped.save_on_salesforce
	end

	it "should remove from salesforce" do
		expect_any_instance_of(ForceIntegrator::Integrator).to receive(:destroy)
		@mapped.remove_from_salesforce
	end

end
