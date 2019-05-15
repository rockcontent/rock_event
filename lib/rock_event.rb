require "segment/analytics"
require_relative "rock_event/client"
require_relative "rock_event/event"
require "rock_event/version"

module RockEvent
  class << self
    def configure(config)
      @client = Client.new(config)
    end

    #
    # { event: "", payload: {}, user_id: 1 }
    #
    def track(*args)
      execute do
        client.track(*args)
      end
    end

    #
    # { payload: {}, user_id: 1, anonymous_id: 1 }
    #
    def identify(*args)
      execute do
        client.identify(*args)
      end
    end

    #
    # { payload: {}, user_id: 1, group_id: 1 }
    #
    def group(*args)
      execute do
        client.group(*args)
      end
    end

    private

    attr_reader :client

    def execute
      return nil if !client

      yield if block_given?
    end
  end
end
