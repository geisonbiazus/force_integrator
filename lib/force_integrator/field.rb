class ForceIntegrator::Field
  attr_accessor :sf_field, :model_field

  def initialize(sf_field, model_field)
    self.sf_field = sf_field
    self.model_field = model_field
  end

end