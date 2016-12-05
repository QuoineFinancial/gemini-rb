module Gemini
  module Balances
    def self.all(options = {})
      Gemini.sanity_check!
      balances = Gemini::Net.post("/v1/balances", options, true)
      JSON.parse(balances).map do |balance|
        Gemini::Balance.new(balance)
      end
    end
  end
end
