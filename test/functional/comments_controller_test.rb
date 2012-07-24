require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get _comments" do
    get :_comments
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
