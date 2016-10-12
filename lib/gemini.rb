require "gemini/version"
require "gemini/net"
require "gemini/model"
require "gemini/orders"
require "gemini/executions"
require "gemini/balances"

module Gemini
  class << self
    # API Key
    attr_accessor :key
    # API secret
    attr_accessor :secret
  end

  def self.setup
    yield self
  end

  def self.configured?
    key && secret
  end

  def self.sanity_check!
    unless configured?
      raise MissingConfigExeception.new("Gemini Gem not properly configured")
    end
  end

  class MissingConfigExeception < RuntimeError; end
end
