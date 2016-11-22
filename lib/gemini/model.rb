require "virtus"

module Gemini
  class Order
    include Virtus.value_object

    values do
      attribute :order_id, String
      attribute :client_order_id, String
      attribute :symbol, String
      attribute :exchange, String
      attribute :price, Decimal
      attribute :avg_execution_price, Decimal
      attribute :side, String
      attribute :type, String
      attribute :timestamp, Integer
      attribute :timestampms, Float
      attribute :is_live, Boolean
      attribute :is_cancelled, Boolean
      attribute :was_forced, Boolean
      attribute :executed_amount, Decimal
      attribute :remaining_amount, Decimal
      attribute :original_amount, Decimal
    end
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

    values do
      attribute :currency, String
      attribute :amount, Decimal
      attribute :available, Decimal
    end
  end
end
