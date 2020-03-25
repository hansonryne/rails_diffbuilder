require 'test_helper'

class DiffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diff = diffs(:one)
  end

  test "should get index" do
    get diffs_url
    assert_response :success
  end

  test "should get new" do
    get new_diff_url
    assert_response :success
  end

  test "should create diff" do
    assert_difference('Diff.count') do
      post diffs_url, params: { diff: { notes: @diff.notes, path: @diff.path, reason: @diff.reason, review_id: @diff.review_id, status: @diff.status } }
    end

    assert_redirected_to diff_url(Diff.last)
  end

  test "should show diff" do
    get diff_url(@diff)
    assert_response :success
  end

  test "should get edit" do
    get edit_diff_url(@diff)
    assert_response :success
  end

  test "should update diff" do
    patch diff_url(@diff), params: { diff: { notes: @diff.notes, path: @diff.path, reason: @diff.reason, review_id: @diff.review_id, status: @diff.status } }
    assert_redirected_to diff_url(@diff)
  end

  test "should destroy diff" do
    assert_difference('Diff.count', -1) do
      delete diff_url(@diff)
    end

    assert_redirected_to diffs_url
  end
end
