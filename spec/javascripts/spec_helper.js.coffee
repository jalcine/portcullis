#= require jquery
#= require_tree ./support

# Disable jQuery effects.
$.fx.off = true

# Extend the time of mocha.
mocha.timeout 10

# Lemme see what's going on.
chai.Assertion.includeStack = true
ENV = { TESTING: true }
