# frozen_string_literal: true

desc 'Check yaml stock prices'
task :check_prices, %i[filename] do |_task_name, args|
  require_relative './../../system/boot'

  filename = args[:filename]

  transaction_key = 'transactions.check_yaml_prices'
  logger = Notifier.logger

  Notifier.monitor(transaction_key) do |event|
    payload = event.payload
    logger.info "Prices checked with args: #{payload[:args]} in #{payload[:time]}ms"
  end

  Notifier[transaction_key].(filename: filename) do |result|
    result.success do
      puts "Prices checked at #{Time.now}"
    end

    result.failure :parse_yaml do |error|
      message = "Failed to parse prices config due to error: #{error}"
      logger.info message
      puts message
    end
  end
end
