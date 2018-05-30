var global_context = [];
exports.describe = function(description, test_block) {
  global_context.push(description);
  test_block()
  global_context.pop();
};

exports.context = exports.describe;

exports.it = function(description, test) {
  QUnit.test(global_context.concat([description]).join(" "), test);
};
