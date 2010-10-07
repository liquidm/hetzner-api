require 'httparty'
require 'forwardable'

require 'hetzner/api/cli'
require 'hetzner/api/boot'
require 'hetzner/api/failover'
require 'hetzner/api/rdns'
require 'hetzner/api/rescue'
require 'hetzner/api/reset'
require 'hetzner/api/vnc'
require 'hetzner/api/windows'
require 'hetzner/api/wol'

module Hetzner
  class API
    include ::HTTParty
    format :json
    base_uri 'https://robot-ws.your-server.de'
        
    include Boot
    include Failover
    include Rdns
    include Rescue
    include Reset
    include VNC
    include Windows
    include WOL
    
    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end
    
  private
    
    def perform_get(path, options = {})
      options.merge!({:basic_auth => @auth})
      Hetzner::API.get path, options
    end
    
    def perform_post(path, options = {})
      options.merge!({:basic_auth => @auth})
      options[:headers] = { 'Content-Type' => 'application/x-www-form-urlencoded' }
      Hetzner::API.post path, options
    end
    
    def perform_delete(path, options = {})
      options.merge!({:basic_auth => @auth})
      Hetzner::API.delete path, options
    end
    
    def perform_put(path, options = {})
      options.merge!({:basic_auth => @auth})
      Hetzner::API.put path, options
    end
  end
end