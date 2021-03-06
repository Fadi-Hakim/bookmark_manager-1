require 'capybara/rspec'
require 'database_cleaner'
require 'factory_girl'

require File.join(File.dirname(__FILE__), '../app/bookmark_manager.rb')
Capybara.app = BookmarkManager

RSpec.configure do |config|
  
  config.include FactoryGirl::Syntax::Methods 
  FactoryGirl.definition_file_paths = %w{./spec/factories}
  FactoryGirl.find_definitions

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
