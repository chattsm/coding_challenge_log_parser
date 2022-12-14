# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'json'

base_path = File.expand_path('../lib', __dir__)
$LOAD_PATH << base_path

def fixture_path(name)
  File.expand_path("support/fixtures/#{name}", __dir__)
end

def generate_json(hash)
  JSON.generate(hash)
end

RSpec.configure do |config|
  config.order = 'random'
end
