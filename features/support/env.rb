$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "minitest/spec"

World(MiniTest::Assertions)
MiniTest::Spec.new(nil)
