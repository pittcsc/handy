require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @event = events(:meeting)
  end

  test 'requires name' do
    assert @event.valid?

    @event.name = ''
    assert @event.invalid?
  end

  test 'requires date' do
    assert @event.valid?

    @event.date = nil
    assert @event.invalid?
  end

  test 'finds current' do
    assert_equal [@event], Event.current
  end

  test 'generates token from two random words' do
    Dictionary.expects(:sample).with(2).returns(['grape', 'thing'])

    event = Event.create!(name: 'Meeting', date: '2014-11-01')
    assert_equal 'grape thing', event.token
  end

  test 'tries 100 times to generate a unique token' do
    Dictionary.expects(:sample).with(2).times(100).returns(['grape', 'thing'])
    Event.expects(:find_by_token).with('grape thing').times(100).returns(@event)

    assert_raises RuntimeError do
      Event.create!(name: 'Meeting', date: '2014-11-01')
    end
  end
end
