# frozen_string_literal: true

Notifier.boot :logger do
  start do |container|
    container[:logger].level = ENV.fetch('LOG_LEVEL', 0)
  end
end
