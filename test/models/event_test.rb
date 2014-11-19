require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'requires name' do
    event = events(:meeting)
    assert event.valid?

    event.name = ''
    assert event.invalid?
  end

  test 'requires date' do
    event = events(:meeting)
    assert event.valid?

    event.date = nil
    assert event.invalid?
  end

  test 'finds current' do
    assert_equal [events(:meeting)], Event.current
  end

  test 'generates token from two random words' do
    Dictionary.expects(:sample).with(2).returns(['grape', 'thing'])

    event = Event.create!(name: 'Meeting', date: '2014-11-01')
    assert_equal 'grape thing', event.token
  end
end
