# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/components'

class Notifier < Dry::System::Container
  use :logging
  use :monitoring
  use :env, inferrer: -> { ENV.fetch('RACK_ENV', :development).to_sym }

  configure do |config|
    config.auto_register = %w(lib)
    config.default_namespace = 'notifier'
  end

  load_paths!('lib', 'system')
end
