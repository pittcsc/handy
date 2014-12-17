require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    log_in_as users(:jeff)
    @organization = organizations(:csc)
  end

  test 'index' do
    get(:show, {'organization_id' => @organization.id})

    assert_response :success
    assert_equal @organization.events.order(date: :desc).page(1), assigns(:events)
  end

  test 'index paginates' do
    create_paginated_events
    get(:show, {'organization_id' => @organization.id})

    assert_response :success
    assert_equal 30, assigns(:events).size
  end

  test 'index paginates on last page' do
    create_paginated_events
#    get :index, page: 2
    get(:show, {'organization_id' => @organization.id, 'page' => 2})

    assert_response :success
    assert_equal 20, assigns(:events).size
  end

  test 'index paginates with negative page number' do
    create_paginated_events
    #get :index, page: -100
    get(:show, {'organization_id' => @organization.id, 'page' => -100})

    assert_response :success
    assert_equal 30, assigns(:events).size
  end

  test 'index paginates with invalid page number' do
    create_paginated_events
    get :index, page: 'foo'
    get(:show, {'organization_id' => @organization.id, 'page' => 'foo'})

    assert_response :success
    assert_equal 30, assigns(:events).size
  end

  test 'show' do
    get :show, id: events(:meetingCsc)

    assert_response :success
    assert_equal events(:meetingCsc).attendees, assigns(:attendees)
  end

  test 'new' do
    get :new

    assert_response :success
    assert assigns(:event).new_record?
  end

  test 'create' do
    assert_difference -> { Event.count } do
      post :create, event: { name: 'Meeting', date: '2014-11-30', organization: organizations(:csc) }
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

  private
    def create_paginated_events
      Event.delete_all
      50.times do
        Event.create!(name: 'Event', date: Date.today)
      end
    end
end
