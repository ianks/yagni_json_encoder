require 'oj'

class YagniJsonEncoder
  attr_reader :options

  def initialize(options = nil)
    @options = options || {}
  end

  def encode(value)
    Oj.dump value.as_json(options.dup),
            mode: :compat,
            quirks_mode: true
  end
end

require 'activesupport/json_encoder'
