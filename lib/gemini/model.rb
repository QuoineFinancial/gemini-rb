require "virtus"

module Gemini
  class Order
    include Virtus.value_object
  end

  class Execution
    include Virtus.value_object

    values do
      attribute :tid, Integer
      attribute :price, Decimal
      attribute :amount, Decimal
      attribute :timestamp, Integer
      attribute :timestampms, Float
      attribute :type, String
      attribute :aggressor, Boolean
      attribute :fee_currency, String
      attribute :fee_amount, Decimal
      attribute :order_id, String
      attribute :client_order_id, String
      attribute :break, String
    end

    def id
      self.tid
    end
  end

  class Balance
    include Virtus.value_object
  end
end
