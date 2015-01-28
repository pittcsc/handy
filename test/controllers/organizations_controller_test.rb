require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  setup do
    log_in_as users(:jeff)
    @organization = organizations(:csc)
  end

  test 'index' do
    get :index

    assert_response :success
    assert_equal users(:jeff).organizations, assigns(:organizations)
  end

  test 'new' do
    get :new

    assert_response :success
    assert assigns(:organization).new_record?
  end

  test 'create' do
    post :create, organization: { name: "Joel's Club" }

    assert_redirected_to organization_events_url(Organization.last)
    assert_equal "Joel's Club", Organization.last.name

    # Make sure creating user has access to the organization
    assert_equal Access.last.organization_id, Organization.last.id
    assert_equal Access.last.user_id, users(:jeff).id
  end

  test 'edit' do
    get :edit, id: @organization

    assert_response :success
    assert_equal @organization, assigns(:organization)
  end

  test 'update' do
    put :update, id: @organization, organization: { name: "George's Club" }

    assert_redirected_to organization_events_url(@organization)
    assert_equal "George's Club", @organization.reload.name
  end

  test 'destroy' do
    delete :destroy, id: @organization

    assert_redirected_to organizations_url
    assert_not Organization.find_by_id(@organization)
  end
end
