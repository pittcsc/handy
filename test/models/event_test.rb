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
    assert_equal events(:meeting), Event.current
  end

  test 'allows only one current' do
    meeting = events(:meeting)
    workshop = events(:workshop)

    workshop.update!(current: true)
    meeting.reload

    assert_not meeting.current?
    assert workshop.current?
  end

  test 'generates token' do
    Event::Token.stubs(:generate).with(2).returns('grape thing')

    event = Event.create!(name: 'Meeting', date: '2014-11-01')
    assert_equal 'grape thing', event.token
  end
end
