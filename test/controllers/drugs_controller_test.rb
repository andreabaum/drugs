require 'test_helper'

class DrugsControllerTest < ActionController::TestCase
  setup do
    @drug = drugs(:one)
  end

  test "should get edit" do
    get :edit, id: @drug
    assert_response :success
  end

  test "should update drug" do
    patch :update, id: @drug, drug: { active: @drug.active, name: @drug.name, note: @drug.note }
    assert_redirected_to drug_path(assigns(:drug))
  end

  test "should destroy drug" do
    assert_difference('Drug.count', -1) do
      delete :destroy, id: @drug
    end

    assert_redirected_to drugs_path
  end
end
