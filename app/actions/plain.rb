require "hanami/action"

module DemoRubyHanami
  module Actions
    class Plain < Hanami::Action
      def handle(req, res)
        res.body = "Hello World"
      end
    end
  end
end
