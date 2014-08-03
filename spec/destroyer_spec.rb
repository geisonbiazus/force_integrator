require 'spec_helper'

describe ForceIntegrator::Workers::Destroyer do 
	
	it "should instantiate an integrator and destroy" do

		expect_any_instance_of(ForceIntegrator::Integrator).to receive(:destroy)

		savior = ForceIntegrator::Workers::Destroyer.new
		savior.perform(double('contact'))
	end

end