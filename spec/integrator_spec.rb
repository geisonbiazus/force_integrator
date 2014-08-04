require 'spec_helper'

describe ForceIntegrator::Integrator do
	
	before :each do

		@contact_instance = double('contact_instance', :[]= => true, save: true, Id: 'whatever', delete: true)
		@contact_class = double('contact_class', new: @contact_instance, find: @contact_instance)

		@user_class = double('User')

		@client = instance_double(Databasedotcom::Client, materialize: @contact_class)
		allow(@client).to receive(:materialize).with('User').and_return(@user_class)
		
 		@authenticator = instance_double(ForceIntegrator::Authenticator, authenticate: @client, username: 'sky@walker.com')

		allow(@user_class).to receive(:find_by_Email).with(@authenticator.username).and_return(double('user', Id: 'userid'))

		@field_mapper = ForceIntegrator::FieldMapper.new
		@field_mapper.map('Name', :name)

		@person_instance = double('person', 
			name: 'Skywalker', 
			sf_authenticator: @authenticator, 
			class: double('Person', field_mapper: @field_mapper), 
			salesforce_id: nil,
			update_attribute: true)
		
		@integrator = ForceIntegrator::Integrator.new(@person_instance)
	end

	context "on save" do
		
		after :each do 
			@integrator.save
		end

		it "should authenticate on salesforce using the given authentication parameters" do
			expect(@authenticator).to receive(:authenticate)
		end

		it "should materialize the Contact class" do
			expect(@client).to receive(:materialize).with("Contact").and_return(@contact_class)			
		end

		it "should instantiate the Contact class and add the mapped values" do
			expect(@contact_instance).to receive(:[]=).with('Name', 'Skywalker')
		end

		it "should assign the OwnerId according to Salesforce authenticated user" do
			expect(@contact_instance).to receive(:[]=).with('OwnerId', 'userid')
		end

		it "should save a new contact on salesforce" do
			expect(@contact_instance).to receive(:save)
		end

		it "should update the salesforce_id attribute of the model" do
			expect(@person_instance).to receive(:update_attribute).with(:salesforce_id, @contact_instance.Id)
		end

		it "should load the remote Salesforce contact if the given person has a salesforce id" do
			allow(@person_instance).to receive(:salesforce_id).and_return('my_id')
			expect(@contact_class).to receive(:find).with('my_id').and_return(@contact_instance)
		end

	end

	context 'on destroy' do
		
		before :each do
			allow(@person_instance).to receive(:salesforce_id).and_return('my_id')		
		end

		after :each do
			@integrator.destroy
		end

		it "should authenticate on salesforce" do
			expect(@authenticator).to receive(:authenticate)
		end

		it "should remove an contact from salesforce" do
			expect(@contact_class).to receive(:find).with('my_id').and_return(@contact_instance)
			expect(@contact_instance).to receive(:delete)
		end
	end


end