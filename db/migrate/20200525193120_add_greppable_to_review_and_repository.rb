class AddGreppableToReviewAndRepository < ActiveRecord::Migration[6.0]
  def change
    add_reference :greps, :greppable, polymorphic: true
    reversible do |dir|
      dir.up do
        Grep.all.each do |grep|
          grep.greppable_type = 'Repository' if grep.repository_id.present?
          grep.greppable_type = 'Review' if grep.review_id.present?
          grep.greppable_id ? grep.repository_id : grep.review_id
          grep.save
        end
      end
      dir.down do
        Grep.all.each do |grep|
          grep.repository_id = greppable_id if grep.greppable_type = 'Repository'
          grep.review_id = greppable_id if grep.greppable_type = 'Review'
          grep.save
        end
      end
    end
    remove_column :greps, :review_id, index: true
    remove_column :greps, :repository_id, index: true
  end
end
