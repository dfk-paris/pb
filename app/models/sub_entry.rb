class SubEntry < ApplicationRecord

  belongs_to :main_entry
  has_many :media, lambda {order("ISNULL(sequence), sequence ASC")}, dependent: :destroy

  acts_as_taggable_on :inventory_ids

  validates :title, presence: true

  before_validation do |se|
    if se.no_title
      se.title = se.main_entry.title
      se.sequence = se.main_entry.sequence
    end

    [:title, :description, :markings, :restaurations, :material].each do |f|
      if se[f].present?
        se["#{f}_reverse".to_sym] = se[f].reverse
      end
    end
  end

  def title
    no_title ? main_entry.title : super
  end

end
