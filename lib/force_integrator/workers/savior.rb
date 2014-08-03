require 'sidekiq'

module ForceIntegrator::Workers
	class Savior
		include Sidekiq::Worker

		def perform(contact)
			integrator = ForceIntegrator::Integrator.new(contact)
			integrator.save
		end

	end

end