begin
  require 'json'
rescue StandardError
  nil # ignore
end

require "active_support/json"
require 'oj'

class YagniJsonEncoder
  Oj.default_options = { mode: :compat, after_sep: 0 }
  JSON = Oj.mimic_JSON

  attr_reader :options

  def initialize(options = nil)
    @options = options || {}
  end

  def encode(value)
    JSON.generate value.as_json(options.dup),
                  quirks_mode: true,
                  max_nesting: false
  end
end

require 'activesupport/json_encoder'
