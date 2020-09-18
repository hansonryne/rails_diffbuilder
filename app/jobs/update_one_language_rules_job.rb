class UpdateOneLanguageRulesJob < ApplicationJob
  include ActiveJob::Status
  queue_as :default
  
  def perform(language)
    puts job_id
    
    rules_links = Rule.get_rules_urls(language.url)
    puts 'Update One Job: RULES THAT EXIST'
    puts language.rules.count
    puts rules_links.count
    
    if rules_links.count != language.rules.count
      rules_links.each_with_index do |l, i|
        new_rule_object = Rule.build_rule_object(l)
        @new_rule = Rule.new(title: new_rule_object[:title],
          category: new_rule_object[:type],
          body: new_rule_object[:body],
          more_info_links: new_rule_object[:references],
          severity: new_rule_object[:severity],
          language_id: language.id)
        if @new_rule.save
          puts "Update One Job:     RULE #{i + 1} of #{rules_links.length} SAVED"
          if new_rule_object[:tags].count > 0
            # all_tag_names = Tag.pluck(:name)
            new_rule_object[:tags].each do |t|
              @new_rule.tags.create!(name: t)
            rescue ActiveRecord::RecordInvalid => e
              puts e
              Tag.where(name: t).take.rules << @new_rule
            end
          end
        end
      end
    else
      puts 'Update One Job:   NO NEW RULES TO ADD'
    end
  end
end
