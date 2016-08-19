class SubEntry < ApplicationRecord

  belongs_to :main_entry
  has_many :media, dependent: :destroy

  acts_as_taggable_on :inventory_ids

  validates :title, presence: true

end
