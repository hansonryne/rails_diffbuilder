require 'test_helper'

class GrepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grep = greps(:one)
  end

  test "should get index" do
    get greps_url
    assert_response :success
  end

  test "should get new" do
    get new_grep_url
    assert_response :success
  end

  test "should create grep" do
    assert_difference('Grep.count') do
      post greps_url, params: { grep: { custom: @grep.custom, repository_id: @grep.repository_id, results: @grep.results, review_id: @grep.review_id, rule_id: @grep.rule_id, search_value: @grep.search_value } }
    end

    assert_redirected_to grep_url(Grep.last)
  end

  test "should show grep" do
    get grep_url(@grep)
    assert_response :success
  end

  test "should get edit" do
    get edit_grep_url(@grep)
    assert_response :success
  end

  test "should update grep" do
    patch grep_url(@grep), params: { grep: { custom: @grep.custom, repository_id: @grep.repository_id, results: @grep.results, review_id: @grep.review_id, rule_id: @grep.rule_id, search_value: @grep.search_value } }
    assert_redirected_to grep_url(@grep)
  end

  test "should destroy grep" do
    assert_difference('Grep.count', -1) do
      delete grep_url(@grep)
    end

    assert_redirected_to greps_url
  end
end
