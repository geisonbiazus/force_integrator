require 'sidekiq'

module ForceIntegrator::Workers
	class Destroyer
		include Sidekiq::Worker

		def perform(contact)
			integrator = ForceIntegrator::Integrator.new(contact)
			integrator.destroy
		end

	end

end