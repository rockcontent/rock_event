module RockEvent
  class Client

    def initialize(api_key:)
      @api_key = api_key.to_s
    end

    def track(event:, payload:, user_id:)
      execute do
        client.track(user_id: user_id,
                     event: event,
                     properties: payload,
                     context: { traits: payload })
      end
    end

    def identify(payload:, user_id:, anonymous_id:)
      execute do
        client.identify(user_id: user_id,
                        traits: payload,
                        anonymous_id: anonymous_id)
      end
    end

    def group(payload:, user_id:, group_id:)
      execute do
        client.group(user_id: user_id,
                     group_id: group_id,
                     traits: payload,
                     context: { traits: payload })

      end
    end

    private

    attr_reader :api_key

    def execute
      if !connected? || !block_given?
        false
      else
        case yield
        when Net::HTTPSuccess
          true
        else
          false
        end
      end
    end

    def connected?
      !api_key.empty?
    end

    def client
      @client ||= SimpleSegment::Client.new({ write_key: api_key })
    end
  end
end
