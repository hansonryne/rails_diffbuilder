class MakeReviewAndRepositoryAndRuleOptionalForGrep < ActiveRecord::Migration[6.0]
  def change
    change_column_null :greps, :repository_id, true
    change_column_null :greps, :review_id, true
    change_column_null :greps, :rule_id, true
  end
end
