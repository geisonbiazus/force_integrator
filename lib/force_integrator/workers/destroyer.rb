require 'sidekiq'

module ForceIntegrator::Workers
	class Destroyer
		include Sidekiq::Worker

		def perform(id, klass)
			contact = Object.const_get(klass).find(id)
			integrator = ForceIntegrator::Integrator.new(contact)
			integrator.destroy
		end

	end

end