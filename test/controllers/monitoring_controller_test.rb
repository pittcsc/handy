class MonitoringControllerTest < ActionController::TestCase
  test 'up' do
    get :up
    assert_response :success
  end
end
