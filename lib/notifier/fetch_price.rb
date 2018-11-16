# frozen_string_literal: true

require 'http'

class FetchPrice
  def call(ticker)
    HTTP.get(url(ticker)).yield_self do |response|
      BigDecimal(response.to_s)
    end
  end

  private

  def url(ticker)
    "https://api.iextrading.com/1.0/stock/#{ticker.upcase}/price"
  end
end
