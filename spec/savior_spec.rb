require 'spec_helper'

describe ForceIntegrator::Workers::Savior do 

	it "should instantiate an integrator and save" do

		Contact = Class.new
		expect(Contact).to receive(:find).with('1').and_return(double('contact'))

		expect_any_instance_of(ForceIntegrator::Integrator).to receive(:save)

		savior = ForceIntegrator::Workers::Savior.new
		savior.perform('1', 'Contact')
	end

end