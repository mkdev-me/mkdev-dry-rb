# frozen_string_literal: true

desc 'Check stock price'
task :check_price, %i[ticker price] do |_task_name, args|
  require_relative './../../system/boot'

  ticker = args[:ticker]
  price = BigDecimal(args[:price])

  Notifier.monitor('notifier.main') do |event|
    payload = event.payload
    Notifier.logger.info "Price checked with args: #{payload[:args]} in #{payload[:time]}ms"
  end

  loop do
    Notifier['notifier.main'].call(ticker, price)
    sleep 10
  end
end
