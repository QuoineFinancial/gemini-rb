module Gemini
  module Orders
    def self.create(options = {})
      Gemini.sanity_check!
      result = Gemini::Net.post("/v1/order/new", options)
      Gemini::Order.new(JSON.parse(result))
    end

    def self.cancel(options = {})
      Gemini.sanity_check!
      Gemini::Net.post("/v1/me/cancelchildorder", options)
    end
  end
end
