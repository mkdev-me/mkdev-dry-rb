# frozen_string_literal: true

require 'bundler/setup'
require_relative 'container'
require_relative 'import'

Notifier.finalize!
