class Repository < ApplicationRecord
  include Greppable
#  has_many :greps, as: :greppable, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :repos_langs
  has_many :languages, through: :repos_langs, dependent: :destroy



  validates :name, :presence => true
  validates :project, :presence => true
  validates :repo_location, :presence => true

  def get_commit_message_and_date
    @commits = self.get_commits
    return "#{@commit.message}: #{@commit.date}" 
  end


  def get_commits
    if self.secret_path
      @commits = Git.open(self.get_secret_path).log
    end
  end

  def get_secret_path
    Rails.root.join("storage", "repositories", self.secret_path)
  end

end
