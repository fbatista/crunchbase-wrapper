require 'faraday'
require 'json'
require 'hashie'

module Crunchbase
  class FundingRound

    attr_accessor :metadata

    def initialize(data, meta)
      @mash = data
      self.metadata = meta
    end

    def method_missing(method_sym, *arguments, &block)
      @mash.send(method_sym, *arguments)
    end

    def self.find(uuid)
      response = Faraday.get("#{Crunchbase.config.host}/#{Crunchbase.config.api_version_prefix}/funding-round/#{uuid}", user_key: Crunchbase.config.user_key)

      raise "Error" if response.status != 200

      raw = Hashie::Mash.new(JSON.parse(response.body))
      new(raw.data, raw.metadata)
    rescue
      nil
    end

  end
end
