require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    log_in_as users(:jeff)
    @organization = organizations(:csc)
  end

  test 'index' do
    get :index, organization_id: @organization

    assert_response :success
    assert_equal @organization.events.order(date: :desc).page(1), assigns(:events)
  end

  test 'index paginates' do
    create_paginated_events
    get :index, organization_id: @organization

    assert_response :success
    assert_equal 30, assigns(:events).size
  end

  test 'index paginates on last page' do
    create_paginated_events
    get :index, page: 2, organization_id: @organization

    assert_response :success
    assert_equal 20, assigns(:events).size
  end

  test 'index paginates with negative page number' do
    create_paginated_events
    get :index, {organization_id: @organization, page: -100}

    assert_response :success
    assert_equal 30, assigns(:events).size
  end

  test 'index paginates with invalid page number' do
    create_paginated_events
    get :index, {organization_id: @organization, page: 'foo'}

    assert_response :success
    assert_equal 30, assigns(:events).size
  end

  test 'show' do
    get :show, id: events(:csc_meeting), organization_id: @organization

    assert_response :success
    assert_equal events(:csc_meeting).attendees, assigns(:attendees)
  end

  test 'show checks freshness' do
    request.headers['If-Modified-Since'] = events(:csc_meeting).updated_at.httpdate
    get :show, organization_id: @organization.id, id: events(:csc_meeting)

    assert_response :not_modified
  end

  test 'new' do
    get :new, organization_id: @organization

    assert_response :success
    assert assigns(:event).new_record?
  end

  test 'create' do
    assert_difference -> { Event.count } do
      post :create, event: { name: 'Meeting', date: '2014-11-30' }, organization_id: @organization
    end

    assert_redirected_to organization_event_url(@organization, Event.last)
    assert_equal 'Meeting', Event.last.name
    assert_equal Date.parse('2014-11-30'), Event.last.date
  end

  test 'edit' do
    get :edit, id: events(:csc_meeting), organization_id: @organization

    assert_response :success
  end

  test 'update' do
    put :update, id: events(:csc_meeting), event: { name: 'New name' }, organization_id: @organization

    assert_redirected_to organization_events_url(@organization)
    assert_equal 'New name', events(:csc_meeting).reload.name
  end

  test 'destroy' do
    delete :destroy, id: events(:csc_meeting), organization_id: @organization

    assert_redirected_to organization_events_url(@organization)
    assert_not Event.find_by_id(events(:csc_meeting).id)
  end

  test 'activate' do
    request.env['HTTP_REFERER'] = organization_events_url(@organization)
    post :activate, id: events(:workshop), organization_id: @organization

    assert_redirected_to organization_events_url(@organization)
    assert events(:workshop).reload.active?
  end

  test 'deactivate' do
    request.env['HTTP_REFERER'] = organization_events_url(@organization)
    post :deactivate, id: events(:csc_meeting), organization_id: @organization

    assert_redirected_to organization_events_url(@organization)
    assert_not events(:csc_meeting).reload.active?
  end

  private
    def create_paginated_events
      Event.delete_all
      50.times do
        event = Event.create!(name: 'Event', date: Date.today)
        EventOwnership.create!(organization: @organization, event: event)
      end
    end
end
