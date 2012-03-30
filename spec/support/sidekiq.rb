module Sidekiq
  module Worker
    module ClassMethods
      def perform_async(*args)
        raise "Cannot push to Sidekiq in test environment. You should set an RSpec expectation that \n" +
              "#{self}.should_receive(:perform_async).with(#{args})"
      end
    end
  end
end