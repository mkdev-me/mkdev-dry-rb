# frozen_string_literal: true

module Operations
  class Notify
    include Dry::Transaction::Operation

    def call(input)
      buy = input.fetch :buy
      sell = input.fetch :sell
      prices = input.fetch :prices

      buy.each do |ticker|
        ticker_price = prices[ticker]
        `say "#{ticker} price is #{ticker_price}, time to buy"`
      end

      sell.each do |ticker|
        ticker_price = prices[ticker]
        `say "#{ticker} price is #{ticker_price}, time to sell"`
      end
    end
  end
end
