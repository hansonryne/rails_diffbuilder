require 'test_helper'

class RuleTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rule_tag = rule_tags(:one)
  end

  test "should get index" do
    get rule_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_rule_tag_url
    assert_response :success
  end

  test "should create rule_tag" do
    assert_difference('RuleTag.count') do
      post rule_tags_url, params: { rule_tag: { name: @rule_tag.name, rule_id: @rule_tag.rule_id } }
    end

    assert_redirected_to rule_tag_url(RuleTag.last)
  end

  test "should show rule_tag" do
    get rule_tag_url(@rule_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_rule_tag_url(@rule_tag)
    assert_response :success
  end

  test "should update rule_tag" do
    patch rule_tag_url(@rule_tag), params: { rule_tag: { name: @rule_tag.name, rule_id: @rule_tag.rule_id } }
    assert_redirected_to rule_tag_url(@rule_tag)
  end

  test "should destroy rule_tag" do
    assert_difference('RuleTag.count', -1) do
      delete rule_tag_url(@rule_tag)
    end

    assert_redirected_to rule_tags_url
  end
end
