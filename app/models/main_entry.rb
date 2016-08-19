class MainEntry < ApplicationRecord

  has_many :sub_entries, dependent: :destroy

  validates :title, presence: true

end
