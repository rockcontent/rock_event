require "spec_helper"

RSpec.describe RockEvent::Event do
  describe "constants" do
    describe "AVAILABLE" do
      it "returns a Hash" do
        expected_response = {
          comment: ["create", "destroy"],
          idea: ["create", "approve", "reject", "adjust"],
          submission: ["create", "approve"],
          task: [
            "create", "submit", "reject", "pick", "left",
            "expire", "approve", "automatically_submit", "publish"
          ],
          project: ["create", "update", "churn"],
          user: ["create"],
        }

        expect(RockEvent::Event::AVAILABLE).to eq(expected_response)
      end
    end
  end

  describe ".get" do
    context "with invalid parameters" do
      context "when resource is null" do
        it "raises StandardError exception" do
          stub_const("RockEvent::Event::AVAILABLE", { resource: ["create"] })

          expect {
            RockEvent::Event.get(resource: "resource", action: :foo)
          }.to raise_error(StandardError)
        end
      end

      context "when action is null" do
        it "raises StandardError exception" do
          stub_const("RockEvent::Event::AVAILABLE", { resource: ["create"] })

          expect {
            RockEvent::Event.get(resource: "resource", action: :foo)
          }.to raise_error(StandardError)
        end
      end
    end

    context "with valid parameters" do
      context "when event exists" do
        it "returns event name formatted 'resource.action'" do
          stub_const("RockEvent::Event::AVAILABLE", { resource: ["create"] })
          expected_response = "resource.create"

          result = RockEvent::Event.get(resource: :resource, action: :create)

          expect(result).to eq(expected_response)
        end

        it "returns event name always lower case" do
          stub_const("RockEvent::Event::AVAILABLE", { resource: ["create"] })
          expected_response = "resource.create"

          result = RockEvent::Event.get(resource: "RESOURCE", action: "CREATE")

          expect(result).to eq(expected_response)
        end
      end

      context "when resource not exist" do
        it "raises StandardError exception" do
          stub_const("RockEvent::Event::AVAILABLE", { resource: ["create"] })

          expect {
            RockEvent::Event.get(resource: "resource", action: :foo)
          }.to raise_error(StandardError)
        end
      end

      context "when action not exist" do
        it "raises StandardError exception" do
          stub_const("RockEvent::Event::AVAILABLE", { resource: ["create"] })

          expect {
            RockEvent::Event.get(resource: "resource", action: :foo)
          }.to raise_error(StandardError)
        end
      end
    end
  end
end
