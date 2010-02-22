require 'test/test_helper'
require 'nanotest/error_handling'

module Nanotest
  class << self
    def errors() @@errors end
    def pop
      [failures, errors].select { |ary| ary.size == dots.size }.each { |ary| ary.pop }
      dots.pop
    end
    def reset
      @@dots, @@failures, @@errors = [], [], []
    end
  end
end


include  Nanotest

begin
  assert() { raise 'hell' }
  Nanotest.reset
  assert("should not raise errors") { true }
rescue
  assert("should not reach rescue-block since errors are caught") { false }
end


assert() { raise 'hell' }
assert("should add an E to dots") { Nanotest.dots.last == 'E' }
assert("should add an error") { Nanotest.errors.size == 1 }

Nanotest.errors.clear and Nanotest.dots.reject! {|d| d == 'E'} # clean output
