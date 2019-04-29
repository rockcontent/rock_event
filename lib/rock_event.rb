require "segment/analytics"
require_relative "rock_event/client"
require "rock_event/version"

module RockEvent
  class << self
    def configure(config)
      @client = Client.new(config)
    end

    def track(*args)
      client.track(*args)
    end

    def identify(*args)
      client.identify(*args)
    end

    def group(*args)
      client.group(*args)
    end

    private

    attr_reader :client
  end
end
