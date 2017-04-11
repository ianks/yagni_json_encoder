module ActiveSupport
  self.json_encoder = YagniJsonEncoder

  def self.escape_html_entities_in_json=(*_args)
    raise StandardError,
          'escape_html_entities_in_json is not supported in YagniJsonEncoder'
  end

  def self.parse_json_times
    raise StandardError,
          'ActiveSupport.parse_json_times not supported in YagniJsonEncoder'
  end

  module JSON
    def self.decode(json)
      YagniJsonEncoder::JSON.parse(json, quirks_mode: true)
    end
  end
end
