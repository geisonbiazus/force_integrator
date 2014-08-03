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
	end
	
	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end