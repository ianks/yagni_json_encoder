require 'oj'
Oj.mimic_JSON

class YagniJsonEncoder
  attr_reader :options

  def initialize(options = nil)
    @options = options || {}
    @options.freeze
  end

  def encode(value)
    Oj.dump value.as_json(options)
  end
end

require 'activesupport/json_encoder'
