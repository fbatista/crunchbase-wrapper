require 'faraday'
require 'json'
require 'hashie'

module Crunchbase
  class Location

    attr_accessor :metadata

    def initialize(data, meta)
      @mash = data
      self.metadata = meta
    end

    def method_missing(method_sym, *arguments, &block)
      @mash.send(method_sym, *arguments)
    end

    def self.all(options = {})
      opts = options.merge({user_key: Brainspace.config.user_key})
      response = Faraday.get("#{Brainspace.config.host}/#{Brainspace.config.api_version_prefix}/locations", opts)

      raise "Error" if response.status != 200

      # ignore paging
      raw = Hashie::Mash.new(JSON.parse(response.body))
      collection = raw.data.items
      collections.map { |item| new(item, raw.metadata) }
    rescue
      []
    end

  end
end
