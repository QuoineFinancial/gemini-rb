module Gemini
  module Executions
    def self.me(options = {})
      Gemini.sanity_check!
      executions = Gemini::Net.get("/v1/mytrades", options, true)
      JSON.parse(executions).map do |execution|
        Gemini::Execution.new(execution)
      end
    end
  end
end