require 'rubygems'
require 'bundler/setup'
require 'pry'

Dir[File.expand_path("../../", __FILE__) + "/lib/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
end