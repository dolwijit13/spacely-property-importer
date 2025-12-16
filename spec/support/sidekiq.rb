require 'sidekiq/testing'

RSpec.configure do |config|
  config.before(:each) do
    Sidekiq::Worker.clear_all
  end

  # Run jobs inline for integration tests
  config.around(:each, :perform_enqueued) do |example|
    Sidekiq::Testing.inline! do
      example.run
    end
  end

  # Test job enqueuing for unit tests
  config.around(:each, :test_enqueuing) do |example|
    Sidekiq::Testing.fake! do
      example.run
    end
  end
end
