class ChangeSeachtermRuleIdAllowNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :searchterms, :rule_id, true
  end
end
