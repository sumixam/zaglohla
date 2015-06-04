class Spare < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,  type: 'integer', index: 'not_analyzed'
    indexes :manufacture, type: 'string'
    indexes :number, type: 'string'
    indexes :title, type: 'string'
    indexes :seller, type: 'string'
    indexes :avalaible, type: 'string'
    indexes :price,      type: 'integer'
  end

  def to_indexed_json
    {
      id: id,
      number: number,
      manufacture: manufacture,
      title: title,
      seller: seller,
      avalaible: avalaible,
      price: price
    }.stringify_keys.to_json
  end
end
