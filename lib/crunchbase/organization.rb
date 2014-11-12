require 'faraday'
require 'json'
require 'hashie'

module Crunchbase
  class Organization

    attr_accessor :metadata

    def initialize(data, meta)
      @mash = data
      self.metadata = meta
    end

    def method_missing(method_sym, *arguments, &block)
      @mash.send(method_sym, *arguments)
    end

    def load_details
      if properties
        return self
      else
        Organization.find(path.sub("organization/", ''))
      end
    end

    def self.all(options = {})
      opts = options.merge({user_key: Crunchbase.config.user_key})
      response = Faraday.get("#{Crunchbase.config.host}/#{Crunchbase.config.api_version_prefix}/organizations", opts)

      raise "Error" if response.status != 200

      # ignore paging
      raw = Hashie::Mash.new(JSON.parse(response.body))
      collection = raw.data.items
      collection.map { |item| new(item, raw.metadata) }
    rescue => e
      []
    end

    def self.find(permalink)
      response = Faraday.get("#{Crunchbase.config.host}/#{Crunchbase.config.api_version_prefix}/organization/#{permalink}", user_key: Crunchbase.config.user_key)

      raise "Error" if response.status != 200

      raw = Hashie::Mash.new(JSON.parse(response.body))

      new(raw.data, raw.metadata)
    rescue
      nil
    end

  end
end
