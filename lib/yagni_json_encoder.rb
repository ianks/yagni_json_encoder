require 'oj'

class YagniJsonEncoder
  attr_reader :options

  def initialize(options = nil)
    @options = options || {}
  end

  def encode(value)
    Oj.dump jsonify(value.as_json(options.dup)),
            quirks_mode: true
  end

  private

  def jsonify(value)
    case value
    when Numeric, NilClass, TrueClass, FalseClass, String
      value
    when Hash
      Hash[value.map { |k, v| [jsonify(k), jsonify(v)] }]
    when Array
      value.map { |v| jsonify(v) }
    else
      jsonify value.as_json
    end
  end
end
