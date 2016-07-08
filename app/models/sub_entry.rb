class SubEntry < ApplicationRecord

  belongs_to :main_entry
  has_many :media

  acts_as_taggable_on :inventory_ids

end
