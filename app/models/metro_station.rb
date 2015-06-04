class MetroStation < ActiveRecord::Base
  before_save :add_slug

  def add_slug
    self.slug = Russian.translit(name).parameterize
  end
end
