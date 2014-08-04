require 'sidekiq'

module ForceIntegrator::Workers
	class Savior
		include Sidekiq::Worker

		def perform(id, klass)
			contact = Object.const_get(klass).find(id)
			integrator = ForceIntegrator::Integrator.new(contact)
			integrator.save
		end

	end

end