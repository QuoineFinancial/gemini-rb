require "rest_client"
require "net/http"
require 'digest/hmac'
require 'digest/sha2'
require 'base64'

module Gemini
  module Net
    def self.to_uri(path)
      return "https://api.gemini.com#{path}"
    end

    def self.get(path, options = {}, private_api = false)
      begin
        path += "?#{URI.encode_www_form(options)}" unless options.empty?
        if private_api
          RestClient.get(self.to_uri(path), self.headers_for(path))
        else
          RestClient.get(self.to_uri(path))
        end
      rescue RestClient::BadRequest => e
        raise BadRequest.new(e.response)
      end
    end

    def self.post(path, options = {})
      begin
        RestClient.post(self.to_uri(path), options.to_json, self.headers_for(path, options, "POST"))
      rescue RestClient::BadRequest => e
        raise BadRequest.new(e.response)
      end
    end

    class BadRequest < RuntimeError; end

    private

    def self.headers_for(path, options = {}, method = "GET")
      payload = {"request" => path, "nonce" => (Time.now.to_f * 10000).to_i.to_s}
      payload.merge!(options)
      payload_enc = Base64.encode64(payload.to_json).gsub(/\s/, '')
      signature = Digest::HMAC.hexdigest(payload_enc, Gemini.secret, Digest::SHA384)
      {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "X-GEMINI-APIKEY" => Gemini.key,
        "X-GEMINI-PAYLOAD" => payload_enc,
        "X-GEMINI-SIGNATURE" => signature
      }
    end
  end
end
