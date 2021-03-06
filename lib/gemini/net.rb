require "rest_client"
require "net/http"
require 'base64'
require 'openssl'

module Gemini
  module Net
    def self.to_uri(path)
      if Gemini.sandbox
        "https://api.sandbox.gemini.com#{path}"
      else
        "https://api.gemini.com#{path}"
      end
    end

    def self.get(path, options = {}, private_api = false)
      begin
        path += "?#{URI.encode_www_form(options)}" unless options.empty?
        if private_api
          RestClient.get(self.to_uri(path), self.headers_for(path))
        else
          RestClient.get(self.to_uri(path))
        end
      rescue Exception => e
        raise BadRequest.new(e.response)
      end
    end

    def self.post(path, options = {})
      begin
        RestClient.post(self.to_uri(path), options.to_json, self.headers_for(path, options, "POST"))
      rescue Exception => e
        raise BadRequest.new(e.response)
      end
    end

    class BadRequest < RuntimeError; end

    private

    def self.headers_for(path, options = {}, method = "GET")
      payload = {"request" => path, "nonce" => (Time.now.to_f * 1_000_000_000).to_i.to_s}
      payload.merge!(options)
      payload_enc = Base64.encode64(payload.to_json).gsub(/\s/, '')
      digest = OpenSSL::Digest.new('sha384')
      signature = OpenSSL::HMAC.hexdigest(digest, Gemini.secret, payload_enc)
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
