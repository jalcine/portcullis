#= require jquery
#= require_tree ./support
$.fx.off = true
mocha.timeout 10
chai.Assertion.includeStack = true
ENV = { TESTING: true }
