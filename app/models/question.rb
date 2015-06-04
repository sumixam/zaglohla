class Question < ActiveRecord::Base
  belongs_to :user
  has_many   :answers
  belongs_to :car_engine
  belongs_to :car_brand
  belongs_to :car_model
  belongs_to :car_generation
  belongs_to :job_type
  has_many   :photos, as: :imageable

  accepts_nested_attributes_for :photos, allow_destroy: true

  acts_as_taggable

=begin
  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, type: 'integer', index: 'not_analyzed'
    indexes :topic, analyzer: 'snowball', boost: 100
    indexes :body, analyzer: 'snowball'
    indexes :car_name, type: 'string'
    indexes :car_full_name, type: 'string'
    indexes :car_engine_id, type: 'integer'
    indexes :car_brand_id, type: 'integer'
    indexes :car_model_id, type: 'integer'
    indexes :car_generation_id, type: 'integer'
    indexes :job_type_id, type: 'integer'
    indexes :job_type, type: 'string'
    indexes :created_at, type: 'string'
    indexes :visible, type: 'string'
  end

  def to_indexed_json
    {
      id: id,
      topic: topic,
      body: body,
      car_name: car_name,
      car_full_name: car_full_name,
      car_engine_id: car_engine_id,
      car_brand_id: car_brand_id,
      car_model_id: car_model_id,
      job_type_id: job_type_id,
      job_type: job_type.try(:name) || "",
      car_generation_id: car_generation_id,
      created_at: created_at,
      visible: (visible || false) ? "yes" : "no"
    }.stringify_keys.to_json
  end
=end

  def car_name
    [car_brand.try(:name), car_model.try(:name)].compact.join(" ")
  end

  def car_full_name
    [car_brand.try(:name), car_model.try(:name), car_generation.try(:name), car_engine.try(:name)].compact.join(" ")
  end
end
