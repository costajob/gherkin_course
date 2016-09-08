$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "minitest/spec"
require "bank/account"

World(MiniTest::Assertions)
MiniTest::Spec.new(nil)
