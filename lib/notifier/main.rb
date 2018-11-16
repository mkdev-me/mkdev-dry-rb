# frozen_string_literal: true

class Main
  include Import['notifier.check_price', 'notifier.fetch_price']

  def call(ticker, price)
    check_price.call(fetch_price.call(ticker), price)
  end
end
