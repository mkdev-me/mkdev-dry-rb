# frozen_string_literal: true

module Operations
  class ParseYaml
    include Dry::Transaction::Operation

    YAML_PATH = File.join('./', 'config')

    def call(input)
      filename = input.fetch :filename

      path = File.join(YAML_PATH, "#{filename}.yml")

      return Failure('config file missing') unless File.exist?(path)

      data = YAML.load_file(path).transform_values do |ticker_data|
        ticker_data.transform_values { |price| BigDecimal(price.to_s) }
      end

      Success(tickers_data: data)
    end

    private

    def raw_yaml(filename)
      File.read(File.join(YAML_PATH, "#{filename}.yml"))
    end
  end
end
