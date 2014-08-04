require 'spec_helper'

describe ForceIntegrator::Workers::Destroyer do 
	
	it "should instantiate an integrator and destroy" do

		Contact = Class.new
		expect(Contact).to receive(:find).with('1').and_return(double('contact'))

		expect_any_instance_of(ForceIntegrator::Integrator).to receive(:destroy)

		savior = ForceIntegrator::Workers::Destroyer.new
		savior.perform('1', 'Contact')
	end

end