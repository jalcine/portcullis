#= require jquery
#= require teaspoon/mocha
#= require support/chai
#= require support/chai-backbone
#= require support/chai-datetime
#= require support/chai-jquery

# Make Chai the master.
window.assert = chai.assert
window.expect = chai.expect
window.should = chai.should

# Disable jQuery effects.
$.fx.off = true

# Lemme see what's going on.
chai.Assertion.includeStack = true

ENV = { TESTING: true }
