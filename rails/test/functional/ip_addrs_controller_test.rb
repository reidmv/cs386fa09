require 'test_helper'

class IpAddrsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ip_addrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ip_addr" do
    assert_difference('IpAddr.count') do
      post :create, :ip_addr => { }
    end

    assert_redirected_to ip_addr_path(assigns(:ip_addr))
  end

  test "should show ip_addr" do
    get :show, :id => ip_addrs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ip_addrs(:one).to_param
    assert_response :success
  end

  test "should update ip_addr" do
    put :update, :id => ip_addrs(:one).to_param, :ip_addr => { }
    assert_redirected_to ip_addr_path(assigns(:ip_addr))
  end

  test "should destroy ip_addr" do
    assert_difference('IpAddr.count', -1) do
      delete :destroy, :id => ip_addrs(:one).to_param
    end

    assert_redirected_to ip_addrs_path
  end
end
