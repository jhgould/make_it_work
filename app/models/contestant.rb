class Contestant <ApplicationRecord
  validates_presence_of :name, :age, :hometown, :years_of_experience

  has_many :contestant_projects
  has_many :projects, through: :contestant_projects

  def self.avg_exp
    average(:years_of_experience)
  end
end
