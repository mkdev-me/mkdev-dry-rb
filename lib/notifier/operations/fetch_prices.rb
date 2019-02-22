# frozen_string_literal: true

module Operations
  class FetchPrices
    include Dry::Transaction::Operation

    include Import[:http_library, :logger]

    def call(input)
      tickers_data = input.fetch :tickers_data

      prices = tickers_data.each_with_object({}) do |(ticker, _), memo|
        price = fetch_price(ticker)
        return Failure(:failed_to_fetch_ticker_price) unless price

        memo[ticker] = price
      end

      Success(input.merge(prices: prices))
    end

    private

    def fetch_price(ticker)
      response = http_library.get(url(ticker))
      BigDecimal(response.to_s)
    rescue HTTP::Error => error
      logger.error "Failed to fetch #{ticker} prices: #{error}"
      logger.debug error.backtrace
      false
    end

    def url(ticker)
      "https://api.iextrading.com/1.0/stock/#{ticker}/price"
    end
  end
end
