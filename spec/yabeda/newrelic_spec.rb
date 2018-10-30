# frozen_string_literal: true

RSpec.describe Yabeda::NewRelic do
  it "has a version number" do
    expect(Yabeda::NewRelic::VERSION).not_to be nil
  end

  describe "NewRelic API interaction" do
    let!(:counter)   { Yabeda.counter(:gate_opens) }
    let!(:gauge)     { Yabeda.gauge(:water_level) }
    let!(:histogram) do
      Yabeda.histogram(:gate_throughput, unit: :cubic_meters, per: :gate_open, buckets: [1, 10, 100, 1_000, 10_000])
    end

    before do
      allow(NewRelic::Agent).to receive(:record_metric)
      allow(NewRelic::Agent).to receive(:increment_metric)
    end

    it "calls increment_metric on counter increment" do
      Yabeda.gate_opens.increment(gate: :fake)
      expect(NewRelic::Agent).to have_received(:increment_metric).with("Custom/gate_opens/fake", 1)
    end

    it "calls record_metric on gauge change" do
      Yabeda.water_level.set({}, 42)
      expect(NewRelic::Agent).to have_received(:record_metric).with("Custom/water_level", 42)
    end

    it "calls record_metric on histogram measure" do
      Yabeda.gate_throughput.measure({ gate: 1 }, 4321)
      expect(NewRelic::Agent).to \
        have_received(:record_metric).with("Custom/gate_throughput/1[cubic_meters/gate_open]", 4321)
    end
  end
end
