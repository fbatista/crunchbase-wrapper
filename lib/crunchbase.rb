require 'hashie'
require 'faraday'
require 'json'

require_relative "crunchbase/version"
require_relative "crunchbase/product"
require_relative "crunchbase/person"
require_relative "crunchbase/organization"
require_relative "crunchbase/location"
require_relative "crunchbase/i_p_o"
require_relative "crunchbase/funding_round"
require_relative "crunchbase/fund_raise"
require_relative "crunchbase/category"
require_relative "crunchbase/acquisition"

module Crunchbase
  CONFIG = Hashie::Mash.new({
    host: "https://api.crunchbase.com",
    api_version_prefix: "v/2",
    user_key: nil
  })

  def self.config
    CONFIG
  end

end
