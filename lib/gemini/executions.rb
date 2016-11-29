module Gemini
  module Executions
    def self.me(options = {})
      Gemini.sanity_check!
      executions = Gemini::Net.post("/v1/mytrades", options)
      JSON.parse(executions).map do |execution|
        Gemini::Execution.new(execution)
      end
    end
  end
end
