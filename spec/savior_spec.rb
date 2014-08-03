require 'spec_helper'

describe ForceIntegrator::Workers::Savior do 
	
	it "should instantiate an integrator and save" do

		expect_any_instance_of(ForceIntegrator::Integrator).to receive(:save)

		savior = ForceIntegrator::Workers::Savior.new
		savior.perform(double('contact'))
	end

end