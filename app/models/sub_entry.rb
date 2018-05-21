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

    fields = [
      :title, :description, :markings, :restaurations, :material,
      :creator, :dating, :height, :width, :depth, :diameter, :weight,
      :height_with_socket, :width_with_socket, :depth_with_socket, :framing
    ]
    fields.each do |f|
      if se[f].present?
        se["#{f}_reverse".to_sym] = se[f].reverse
      end
    end

    se.wikidata_people(:markings) if se.markings_changed?
    se.wikidata_people(:restaurations) if se.restaurations_changed?
    se.wikidata_people(:framing) if se.framing_changed?
    se.wikidata_people(:creator) if se.creator_changed?
  end

  def self.all_people
    select(:people).map{|v| v.people}.flatten
  end

  def title
    no_title ? main_entry.title : super
  end

  def people
    (self[:people] || '').split(/\s*;\s*/)
  end

  def people=(list)
    self[:people] = list.join('; ')
  end
end
