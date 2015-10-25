require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  setup do
    @user = users(:jeff)
    @organization = organizations(:csc)

    log_in_as @user
  end

  test 'index' do
    get :index

    assert_response :success
    @user.organizations.each do |organization|
      assert_select 'li', text: organization.name
    end
  end

  test 'new' do
    get :new

    assert_response :success
  end

  test 'create' do
    assert_difference -> { Organization.count } do
      post :create, params: { organization: { name: "Joel's Club" } }
    end

    assert_redirected_to organization_events_url(Organization.last)
    assert_equal "Joel's Club", Organization.last.name
    assert_includes Organization.last.users, @user
  end

  test 'edit' do
    get :edit, params: { id: @organization }

    assert_response :success
  end

  test 'update' do
    put :update, params: { id: @organization, organization: { name: "George's Club" } }

    assert_redirected_to organization_events_url(@organization)
    assert_equal "George's Club", @organization.reload.name
  end

  test 'destroy' do
    assert_difference -> { Organization.count }, -1 do
      delete :destroy, params: { id: @organization }
    end

    assert_redirected_to organizations_url
    assert_not Organization.find_by_id(@organization)
  end
end
