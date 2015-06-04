class SubJobType < ActiveRecord::Base
  belongs_to :job_type
  before_save :add_slug

  def add_slug
    self.slug = Russian.translit(name).parameterize
  end
end
