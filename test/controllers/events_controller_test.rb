require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    log_in_as users(:jeff)

    @organization = organizations(:csc)
    @event = events(:csc_meeting)
  end

  test 'index' do
    get :index, params: { organization_id: @organization }

    assert_response :success
    assert_select 'tbody tr', @organization.events.order(date: :desc).page(1).count
  end

  test 'index paginates' do
    create_paginated_events
    get :index, params: { organization_id: @organization }

    assert_response :success
    assert_select 'tbody tr', 30
  end

  test 'index paginates on last page' do
    create_paginated_events
    get :index, params: { organization_id: @organization, page: 2 }

    assert_response :success
    assert_select 'tbody tr', 20
  end

  test 'index paginates with negative page number' do
    create_paginated_events
    get :index, params: { organization_id: @organization, page: -100 }

    assert_response :success
    assert_select 'tbody tr', 30
  end

  test 'index paginates with invalid page number' do
    create_paginated_events
    get :index, params: { organization_id: @organization, page: 'foo' }

    assert_response :success
    assert_select 'tbody tr', 30
  end

  test 'show' do
    get :show, params: { organization_id: @organization, id: @event }

    assert_response :success
    @event.attendees.each do |attendee|
      assert_select 'li', text: attendee.name
    end
  end

  test 'show checks freshness' do
    request.headers['If-Modified-Since'] = @event.updated_at.httpdate
    get :show, params: { organization_id: @organization.id, id: @event }

    assert_response :not_modified
  end

  test 'new' do
    get :new, params: { organization_id: @organization }

    assert_response :success
  end

  test 'create' do
    assert_difference -> { Event.count } do
      post :create, params: { organization_id: @organization, event: { name: 'Meeting', date: '2014-11-30' } }
    end

    assert_redirected_to organization_event_url(@organization, Event.last)
    assert_equal 'Meeting', Event.last.name
    assert_equal Date.parse('2014-11-30'), Event.last.date
  end

  test 'edit' do
    get :edit, params: { organization_id: @organization, id: @event }

    assert_response :success
  end

  test 'update' do
    put :update, params: { organization_id: @organization, id: @event, event: { name: 'New name' } }

    assert_redirected_to organization_events_url(@organization)
    assert_equal 'New name', @event.reload.name
  end

  test 'destroy' do
    assert_difference -> { Event.count }, -1 do
      delete :destroy, params: { organization_id: @organization, id: @event }
    end

    assert_redirected_to organization_events_url(@organization)
    assert_not Event.find_by_id(@event.id)
  end

  test 'activate' do
    request.env['HTTP_REFERER'] = organization_events_url(@organization)
    post :activate, params: { organization_id: @organization, id: events(:workshop) }

    assert_redirected_to organization_events_url(@organization)
    assert events(:workshop).reload.active?
  end

  test 'deactivate' do
    request.env['HTTP_REFERER'] = organization_events_url(@organization)
    post :deactivate, params: { organization_id: @organization, id: @event }

    assert_redirected_to organization_events_url(@organization)
    assert_not events(:csc_meeting).reload.active?
  end

  private
    def create_paginated_events
      Event.delete_all
      50.times do
        @organization.events.create!(name: 'Event', date: Date.today)
      end
    end
end
