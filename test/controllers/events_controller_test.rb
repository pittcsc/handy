require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    log_in_as users(:jeff)
  end

  test 'index' do
    get :index

    assert_response :success
    assert_equal Event.order(date: :desc), assigns(:events)
  end

  test 'show' do
    get :show, id: events(:meeting)

    assert_response :success
    assert_equal events(:meeting).attendees, assigns(:attendees)
  end

  test 'new' do
    get :new

    assert_response :success
    assert assigns(:event).new_record?
  end

  test 'create' do
    assert_difference -> { Event.count } do
      post :create, event: { name: 'Meeting', date: '2014-11-30' }
    end
    assert_redirected_to Event.last
    assert_equal 'Meeting', Event.last.name
    assert_equal Date.parse('2014-11-30'), Event.last.date
  end

  test 'edit' do
    get :edit, id: events(:meeting)

    assert_response :success
  end

  test 'update' do
    put :update, id: events(:meeting), event: { name: 'New name' }

    assert_redirected_to events_url
    assert_equal 'New name', events(:meeting).reload.name
  end

  test 'destroy' do
    delete :destroy, id: events(:meeting)

    assert_redirected_to events_url
    assert_not Event.find_by_id(events(:meeting).id)
  end

  test 'activate' do
    request.env['HTTP_REFERER'] = events_url
    post :activate, id: events(:workshop)

    assert_redirected_to events_url
    assert events(:workshop).reload.active?
  end

  test 'deactivate' do
    request.env['HTTP_REFERER'] = events_url
    post :deactivate, id: events(:meeting)

    assert_redirected_to events_url
    assert_not events(:meeting).reload.active?
  end
end
