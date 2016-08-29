class MainEntry < ApplicationRecord

  has_many :sub_entries, dependent: :destroy

  validates :title, presence: true

  scope :with_sub_entries, lambda {
    includes(sub_entries: [:inventory_ids, :media]).
    references(:main_entries, :sub_entries, :tags)
  }

  scope :with_order, lambda {
    with_sub_entries.order("main_entries.sequence ASC, sub_entries.sequence ASC")
  }

  scope :by_title, lambda {|title|
    return all if title.blank?
    with_sub_entries.where(
      'main_entries.title LIKE :title OR sub_entries.title LIKE :title',
      title: "%#{title}%"
    )
  }

  scope :by_location, lambda {|location|
    return all if location.blank? || location == '0' || location == 0
    where(location: location)
  }

  scope :by_creator, lambda {|creator|
    return all if creator.blank?
    with_sub_entries.where(
      'sub_entries.creator LIKE :creator',
      creator: "%#{creator}%"
    )
  }

  scope :by_inventory, lambda {|inventory|
    return all if inventory.blank?
    where('LOWER(tags.name) LIKE :name', name: "%#{inventory.downcase}%")
  }

end
