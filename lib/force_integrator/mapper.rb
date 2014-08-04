module ForceIntegrator::Mapper
	module ClassMethods

		def map_fields
			@field_mapper ||= ForceIntegrator::FieldMapper.new
			yield(@field_mapper) if block_given?			
		end

		def field_mapper
			@field_mapper
		end
		
	end
	
	module InstanceMethods
		def sf_authenticator
			@sf_authenticator ||= ForceIntegrator::Authenticator.new
			yield(@sf_authenticator) if block_given?
			@sf_authenticator
		end		

		def save_on_salesforce
			ForceIntegrator::Workers::Savior.perform_async(self.id, self.class.name)
		end

		def remove_from_salesforce
			ForceIntegrator::Workers::Destroyer.perform_async(self.id, self.class.name)
		end
	end
	
	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end