require 'yagni_json_encoder'

module ActiveSupport
  self.json_encoder = YagniJsonEncoder

  def self.escape_html_entities_in_json=(*_args)
    fail StandardError,
         'escape_html_entities_in_json is not supported in YagniJsonEncoder'
  end
end
