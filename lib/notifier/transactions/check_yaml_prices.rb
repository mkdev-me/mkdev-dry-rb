# frozen_string_literal: true

module Transactions
  class CheckYamlPrices
    include Dry::Transaction(container: Notifier)

    step :parse_yaml, with: 'operations.parse_yaml'
    step :fetch_prices, with: 'operations.fetch_prices'
    step :filter_prices, with: 'operations.filter_prices'
    tee :notify, with: 'operations.notify'
  end
end
