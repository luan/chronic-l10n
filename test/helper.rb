require 'chronic'
unless defined? Chronic::L10n
  $:.unshift File.expand_path('../../lib', __FILE__)
  require 'chronic-l10n'
end

require 'minitest/autorun'

class TestCase < MiniTest::Unit::TestCase
  def self.test(name, &block)
    define_method("test_#{name.gsub(/\W/, '_')}", &block) if block
  end
end
