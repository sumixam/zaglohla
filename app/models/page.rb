class Page < ActiveRecord::Base
  belongs_to :parent, class_name: "Page"
  has_many   :childs, class_name: "Page", foreign_key: "parent_id"

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,  type: 'integer', index: 'not_analyzed'
    indexes :title, type: 'string', boost: 2.0
    indexes :body, type: 'string'
  end

  def to_indexed_json
    {
      id: id,
      title: title,
      body: body,
    }.stringify_keys.to_json
  end

  def parent_id_list
    if parent_id != 0
      [id] + parent.parent_id_list
    else
      [id]
    end
  end
end
