# frozen_string_literal: true

require "newrelic_rpm"
require "yabeda/base_adapter"

module Yabeda
  module NewRelic
    # NewRelic adapter. Sends yabeda metrics as custom metrics to NewRelic.
    # See https://docs.newrelic.com/docs/agents/ruby-agent/api-guides/ruby-custom-metrics
    class Adapter < BaseAdapter
      def register_counter!(_metric)
        # Do nothing. NewRelic don't need to register metrics
      end

      def perform_counter_increment!(counter, tags, increment)
        ::NewRelic::Agent.increment_metric(build_name(counter, tags), increment)
      end

      def register_gauge!(_metric)
        # Do nothing. NewRelic don't need to register metrics
      end

      def perform_gauge_set!(metric, tags, value)
        ::NewRelic::Agent.record_metric(build_name(metric, tags), value)
      end

      def register_histogram!(_metric)
        # Do nothing. NewRelic don't need to register metrics
      end

      def perform_histogram_measure!(metric, tags, value)
        ::NewRelic::Agent.record_metric(build_name(metric, tags), value)
      end

      def initialize(*)
        super
        ::NewRelic::Agent.add_instrumentation(File.join(__dir__, "configure.rb"))
      end

      private

      # https://docs.newrelic.com/docs/plugins/plugin-developer-resources/developer-reference/metric-naming-reference
      def build_name(metric, labels = {})
        name = metric.name.to_s
        # Attrs: https://docs.newrelic.com/docs/plugins/plugin-developer-resources/developer-reference/metric-naming-reference#metric_attributes
        name = "#{name}/#{labels.values.join('/')}" if labels.any?
        name += units_for(metric)

        ["Custom", metric.group&.capitalize, name].compact.join("/")
      end

      # https://docs.newrelic.com/docs/plugins/plugin-developer-resources/developer-reference/metric-units-reference
      def units_for(metric)
        return "[#{[metric.unit, metric.per].compact.join('/')}]" if metric.unit
        return "#{name}[|#{metric.per}]" if !metric.unit && metric.per

        ""
      end

      Yabeda.register_adapter(:newrelic, new)
    end
  end
end
