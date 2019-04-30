require "spec_helper"

RSpec.describe RockEvent do
  it "has a version number" do
    expect(RockEvent::VERSION).to eq("0.1.0")
  end

  context "when api key is given" do
    context "with valid credentials" do
      describe ".track" do
        it "returns true", vcr: { cassette_name: "segment_io/valid/track" } do
          RockEvent.configure(api_key: "valid_key")
          result = RockEvent.track(event: "test", payload: { foo: "bar" }, user_id: 1)

          expect(result).to be(true)
        end
      end

      describe ".identify" do
        it "returns true", vcr: { cassette_name: "segment_io/valid/identify" } do
          RockEvent.configure(api_key: "valid_key")
          result = RockEvent.identify(payload: { foo: "bar" }, user_id: 1, anonymous_id: 1)

          expect(result).to be(true)
        end
      end

      describe ".group" do
        it "returns true", vcr: { cassette_name: "segment_io/valid/group" } do
          RockEvent.configure(api_key: "valid_key")
          result = RockEvent.group(payload: { foo: "bar" }, user_id: 1, group_id: 1)

          expect(result).to be(true)
        end
      end
    end

    context "with invalid credentials" do
      describe ".track" do
        it "returns true", vcr: { cassette_name: "segment_io/invalid/track" } do
          RockEvent.configure(api_key: "invalid_key")
          result = RockEvent.track(event: "test", payload: { foo: "bar" }, user_id: 1)

          expect(result).to be(true)
        end
      end

      describe ".identify" do
        it "returns true", vcr: { cassette_name: "segment_io/invalid/identify" } do
          RockEvent.configure(api_key: "invalid_key")
          result = RockEvent.identify(payload: { foo: "bar" }, user_id: 1, anonymous_id: 1)

          expect(result).to be(true)
        end
      end

      describe ".group" do
        it "returns true", vcr: { cassette_name: "segment_io/invalid/group" } do
          RockEvent.configure(api_key: "invalid_key")
          result = RockEvent.group(payload: { foo: "bar" }, user_id: 1, group_id: 1)

          expect(result).to be(true)
        end
      end
    end
  end

  context "when api key is not given" do
    describe ".track" do
      it "returns nil" do
        RockEvent.configure(api_key: nil)
        result = RockEvent.track(event: "test", payload: { foo: "bar" }, user_id: 1)

        expect(result).to be(nil)
      end
    end

    describe ".identify" do
      it "returns nil" do
        RockEvent.configure(api_key: nil)
        result = RockEvent.identify(payload: { foo: "bar" }, user_id: 1, anonymous_id: 1)

        expect(result).to be(nil)
      end
    end

    describe ".group" do
      it "returns nil" do
        RockEvent.configure(api_key: nil)
        result = RockEvent.group(payload: { foo: "bar" }, user_id: 1, group_id: 1)

        expect(result).to be(nil)
      end
    end
  end
end
