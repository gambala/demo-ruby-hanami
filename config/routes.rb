# frozen_string_literal: true

module DemoRubyHanami
  class Routes < Hanami::Routes
    root to: "plain"
    get "/plain", to: "plain"
    get "/json", to: "json"
    get "/html", to: "html"
  end
end
