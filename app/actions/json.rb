require "hanami/action"

module DemoRubyHanami
  module Actions
    class JSON < Hanami::Action
      def handle(req, res)
        res.format = :json
        res.body = { message: "Hello World" }.to_json
      end
    end
  end
end
