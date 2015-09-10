require 'spec_helper'

describe ForceIntegrator::FieldMapper do
  
  it "should add fields to be mapped to salesforce" do
    field_mapper = ForceIntegrator::FieldMapper.new
    field_mapper.map('Name', :first_name)
    field_mapper.map('Email', 'e_mail')

    expect(field_mapper.fields.length).to eq(2)
    expect(field_mapper.fields.first.sf_field).to eq('Name')
    expect(field_mapper.fields.first.model_field).to eq(:first_name)
    expect(field_mapper.fields.last.sf_field).to eq('Email')
    expect(field_mapper.fields.last.model_field).to eq('e_mail')
  end

end