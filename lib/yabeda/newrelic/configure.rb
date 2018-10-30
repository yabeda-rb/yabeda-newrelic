# frozen_string_literal: true

# This file is required by NewRelic agent when it configures itself
# Read more on how NewRelic Ruby agent works under the hood:
# http://mgiroux.me/2016/instrumenting-rails-apps/
# https://qiita.com/k0kubun/items/4810d2044c47e597540f
::NewRelic::Agent.agent.events.subscribe(:before_harvest) do
  Yabeda.collectors.each(&:call)
end
