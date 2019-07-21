require "spec"
require "webmock"

require "../src/base"

Spec.before_each do
  WebMock.reset
end
