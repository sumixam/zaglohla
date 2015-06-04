class JobType < ActiveRecord::Base
  belongs_to :cto
  belongs_to :job_type
  has_many :sub_job_types
  before_save :add_slug

  def add_slug
    self.slug = Russian.translit(name).parameterize
  end
end
