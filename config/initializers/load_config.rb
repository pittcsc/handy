require 'yaml'
require 'twilio-ruby'

module Twilio_Keys
  def self.[](key)
    unless @config
      raw_config = File.read(Rails.root + "config/twilio.yml")
      @config = YAML.load(raw_config).symbolize_keys
    end
    @config[key]
  end

  def self.[]=(key, value)
    @config[key.to_sym] = value
  end
end