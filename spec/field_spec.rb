require 'spec_helper'

describe ForceIntegrator::Field do
  
  it "should store the salesforce field name and the corresponding app model field name" do

    field = ForceIntegrator::Field.new('sf', 'app')

    expect(field.sf_field).to eq('sf')
    expect(field.model_field).to eq('app')

  end

end