class CreateReposLangs < ActiveRecord::Migration[6.0]
  def up
    create_table :repos_langs do |t|
      t.references :repository, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
    # populate join table with existing data
    puts "populating repos_langs"
    Repository.all.each do |repo|
      puts "#{repo.name} is being added to the repos_langs table"
      if repo.languages.nil? == false
        lang_array = ActiveSupport::JSON.decode(repo.languages)
        lang_array.each do |l|
          ReposLang.create(repository_id: repo.id, language_id: Language.find_by(name: l).id)
        end
      end
      puts "There are #{ReposLang.count} repos_langs records"
    end
    # remove obsolete column
    puts "removing old association"
    remove_column :repositories, :languages
  end

  def down
    # add reference column back
    add_reference :repositories, :language, foreign_key: true
    # Using a model after changing its table
    # https://api.rubyonrails.org/classes/ActiveRecord/Migration.html#class-ActiveRecord::Migration-label-Using+a+model+after+changing+its+table
    Repository.reset_column_information
    # associate repository with language, even though it will just be one.
    ReposLang.all.each do |repo_lang|
      Repository.find(repo_lang.repository_id).update_attribute(:language_id, repo_lang.language_id)
    end
    # remove join table
    drop_table :repos_langs
  end
end
