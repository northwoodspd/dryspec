require 'bundler/setup'
require 'dryspec'

RSpec::Expectations.configuration.on_potential_false_positives = :raise
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.extend DRYSpec::Helpers
end
