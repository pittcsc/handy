require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test 'determines first name from full name with one part' do
    assert_equal 'Tyler', Member.new(name: 'Tyler').first_name
  end

  test 'determines first name from full name with two parts' do
    assert_equal 'Victor', Member.new(name: 'Victor Barnes').first_name
  end

  test 'determines first name from full name with three parts' do
    assert_equal 'Jessica', Member.new(name: 'Jessica Rabin Fiske').first_name
  end

  test 'determines first name from full name with one part and irregular spacing' do
    assert_equal 'Tanya', Member.new(name: '  Tanya ').first_name
  end

  test 'determines first name from full name with two parts and irregular spacing' do
    assert_equal 'Rashid', Member.new(name: ' Rashid   Thomas ').first_name
  end

  test 'determines first name with no full name' do
    assert_equal nil, Member.new.first_name
  end
end
