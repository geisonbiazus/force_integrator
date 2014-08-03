module ForceIntegrator::Workers
	class Destroyer

		def perform(contact)
			integrator = ForceIntegrator::Integrator.new(contact)
			integrator.destroy
		end

	end

end