require "virtus"

module Gemini
  class Order
    include Virtus.value_object
  end

  class Execution
    include Virtus.value_object
  end

  class Balance
    include Virtus.value_object
  end
end
