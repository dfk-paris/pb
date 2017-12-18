class MainEntry < ApplicationRecord

  has_many :sub_entries, dependent: :destroy

  validates :title, presence: true

  after_save do |me|
    if me.title_changed? || me.sequence_changed?
      me.sub_entries.each do |se|
        se.save
      end
    end
  end

  scope :mega_join, lambda {
    distinct.
    from('main_entries').
    joins('LEFT OUTER JOIN sub_entries ses ON ses.main_entry_id = main_entries.id').
    joins('LEFT OUTER JOIN taggings ON taggings.taggable_id = ses.id').
    joins('LEFT OUTER JOIN tags ON tags.id = taggings.tag_id')
  }

  scope :with_sub_entries, lambda {
    includes(sub_entries: [:inventory_ids, :media]).
    references(:main_entries, :sub_entries, :tags)
  }

  scope :with_order, lambda {
    mega_join.order("main_entries.sequence ASC")
  }

  scope :by_title, lambda {|title|
    return all if title.blank?
    mega_join.where(
      'main_entries.title LIKE :title OR ses.title LIKE :title',
      title: "%#{title}%"
    )
  }

  scope :by_location, lambda {|location|
    return all if location.blank? || location == '0' || location == 0
    where(location: location)
  }

  scope :by_creator, lambda {|creator|
    return all if creator.blank?
    mega_join.where(
      'ses.creator LIKE :creator',
      creator: "%#{creator}%"
    )
  }

  scope :by_inventory, lambda {|inventory|
    return all if inventory.blank?
    mega_join.where('LOWER(tags.name) LIKE :name', name: inventory.downcase)
  }

  scope :by_terms, lambda {|terms|
    return all if terms.blank?
    mega_join.where("
      (
        MATCH(
          main_entries.title, main_entries.provenience,
          main_entries.historical_evidence, main_entries.literature,
          main_entries.description, main_entries.appreciation
        )
        AGAINST (:terms IN BOOLEAN MODE)
      ) OR (
        MATCH(ses.title, ses.description, ses.markings, ses.restaurations)
        AGAINST (:terms IN BOOLEAN MODE)
      )
    ", terms: terms.split(/\s+/).map{|t| "+#{t}*"}.join(' '))
  }

  scope :include_unpublished, lambda { |value|
    value.present? ? all : where(publish: true)
  }

end
