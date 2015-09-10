class ForceIntegrator::FieldMapper

  attr_reader :fields

  def initialize
    @fields ||= []
  end

  def map(sf_field, model_field)
    @fields << ForceIntegrator::Field.new(sf_field, model_field)
  end

end