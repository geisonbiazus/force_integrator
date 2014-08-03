module ForceIntegrator::Workers
	class Savior

		def perform(contact)
			integrator = ForceIntegrator::Integrator.new(contact)
			integrator.save
		end

	end

end