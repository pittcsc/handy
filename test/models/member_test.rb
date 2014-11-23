require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test 'determines first name' do
    assert_equal 'Victor', Member.new(name: 'Victor Barnes').first_name
    assert_equal 'Jessica', Member.new(name: 'Jessica Rabin Fiske').first_name
    assert_equal 'Tyler', Member.new(name: 'Tyler').first_name
    assert_equal 'Tanya', Member.new(name: '  Tanya ').first_name
    assert_equal nil, Member.new.first_name
  end
end
