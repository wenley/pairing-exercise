var helpers = require('./helpers');
var game = require("../src/game");

var describe = helpers.describe;
var context = helpers.context;
var it = helpers.it;

describe("Game", function() {
  describe("#step", function() {
    it("advances", function(assert) {
      var input = null;
      var output = game.Game.step(input);
      var expectedOutput = null;
      assert.ok(output === expectedOutput, "Passed!");
      assert.equal(output, expectedOutput);
    });
  });
});
