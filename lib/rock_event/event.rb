module RockEvent
  module Event
    AVAILABLE = {
      comment: %w(create destroy),
      idea: %w(create approve reject adjust),
      submission: %w(create approve),
      task: %w(
        create submit reject pick left expire approve automatically_submit publish
      ),
      project: %w(create update churn),
      user: %w(create),
    }.freeze

    class << self
      def get(resource:, action:)
        key = normalize_attribute(resource)
        value = normalize_attribute(action)

        actions = AVAILABLE.fetch(key.to_sym, [])

        return "#{key}.#{value}" if actions.include?(value)

        #TODO raise specific error
        raise StandardError
      end

      private

      def normalize_attribute(resource)
        resource.to_s.downcase
      end
    end
  end
end
