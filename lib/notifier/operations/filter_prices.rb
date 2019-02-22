# frozen_string_literal: true

module Operations
  class FilterPrices
    include Dry::Transaction::Operation

    include Import[:logger]

    def call(input)
      tickers_data = input.fetch :tickers_data
      prices = input.fetch :prices

      buy = []
      sell = []

      prices.each do |ticker, price|
        ticker_data = tickers_data[ticker]
        logger.info "#{ticker.upcase} price: #{price}; boundaries: #{ticker_data}"

        if price <= ticker_data['buy']
          buy << ticker
        else
          sell << ticker
        end
      end

      Success(input.merge(buy: buy, sell: sell))
    end
  end
end
