require "hanami/action"

module DemoRubyHanami
  module Actions
    class Html < Hanami::Action
      def handle(req, res)
        messages = ["Good Morning", "Good Evening", "Good Night"]
        res.body = <<~HTML
          <html>
            <body>
              <ul>
                #{messages.map { |msg| "<li>#{msg}</li>" }.join}
              </ul>
            </body>
          </html>
        HTML
      end
    end
  end
end
