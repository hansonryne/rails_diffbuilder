class AddSearchtermRefToGreps < ActiveRecord::Migration[6.0]
  def change
    add_reference :greps, :searchterm, foreign_key: true
    reversible do |dir|
      dir.up do
        puts "going up"
        Grep.all.each do |grep|
          puts "here"
          st = Searchterm.new(value: grep.search_value, rule_id: grep.rule_id)
          if st.save
            grep.searchterm_id = st.id
            grep.save
          else
            puts "Error saving searchterm"
          end
        end
      end
      dir.down do
        Grep.all.each do |grep|
          grep.search_value = grep.searchterm_id
          puts "Conversion back to search_value failed" unless grep.save
        end
      end
    end
  end
end
