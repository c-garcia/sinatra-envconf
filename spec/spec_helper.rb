require 'rack/test'

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }
