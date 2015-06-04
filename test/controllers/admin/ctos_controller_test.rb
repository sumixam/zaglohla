require 'test_helper'

class Admin::CtosControllerTest < ActionController::TestCase
  setup do
    @admin_cto = admin_ctos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_ctos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_cto" do
    assert_difference('Admin::Cto.count') do
      post :create, admin_cto: { adress_additional: @admin_cto.adress_additional, adress_buildng: @admin_cto.adress_buildng, adress_street: @admin_cto.adress_street, description: @admin_cto.description, email: @admin_cto.email, gov_certificate: @admin_cto.gov_certificate, manufacture_certificate: @admin_cto.manufacture_certificate, name: @admin_cto.name, site: @admin_cto.site }
    end

    assert_redirected_to admin_cto_path(assigns(:admin_cto))
  end

  test "should show admin_cto" do
    get :show, id: @admin_cto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_cto
    assert_response :success
  end

  test "should update admin_cto" do
    patch :update, id: @admin_cto, admin_cto: { adress_additional: @admin_cto.adress_additional, adress_buildng: @admin_cto.adress_buildng, adress_street: @admin_cto.adress_street, description: @admin_cto.description, email: @admin_cto.email, gov_certificate: @admin_cto.gov_certificate, manufacture_certificate: @admin_cto.manufacture_certificate, name: @admin_cto.name, site: @admin_cto.site }
    assert_redirected_to admin_cto_path(assigns(:admin_cto))
  end

  test "should destroy admin_cto" do
    assert_difference('Admin::Cto.count', -1) do
      delete :destroy, id: @admin_cto
    end

    assert_redirected_to admin_ctos_path
  end
end
