class MainEntry < ApplicationRecord

  has_many :sub_entries, dependent: :destroy

  validates :title, presence: true

  before_validation do |me|
    me.title_reverse = me.title.reverse
    me.provenience_reverse = me.provenience.reverse if me.provenience.present?
    me.historical_evidence_reverse = me.historical_evidence.reverse if me.historical_evidence.present?
    me.literature_reverse = me.literature.reverse if me.literature.present?
    me.description_reverse = me.description.reverse if me.description.present?
    me.appreciation_reverse = me.appreciation.reverse if me.appreciation.present?

    me.wikidata_people(:title) if me.title_changed?
    me.wikidata_people(:provenience) if me.provenience_changed?
    me.wikidata_people(:historical_evidence) if me.historical_evidence_changed?
    me.wikidata_people(:literature) if me.literature_changed?
    me.wikidata_people(:description) if me.description_changed?
    me.wikidata_people(:appreciation) if me.appreciation_changed?
  end

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

  scope :by_people, lambda {|term|
    return all if term.blank?
    mega_join.where(
      'main_entries.people LIKE :t OR ses.people LIKE :t',
      t: "%#{term}%"
    )
  }

  scope :by_inventory, lambda {|inventory|
    return all if inventory.blank?

    # inventory.gsub! '|', '[[.vertical-line.]]'
    mega_join.where(
      "LOWER(tags.name) REGEXP :t", t: "(\\||^)#{inventory.downcase}(\\||$)"
    )
  }

  scope :by_terms, lambda {|terms|
    return all if terms.blank?

    locations = JSON.parse(File.read("#{Rails.root}/lib/data/locations.json"))
    rooms = locations.map{|l| l['rooms']}.flatten
    matching_room_ids = rooms.select do |r|
      t = Regexp.quote(terms.downcase)
      r['name'].downcase.match(/#{t}/)
    end.map{|r| r['id']}

    mega_join.where("
      (
        (
          MATCH(
            main_entries.title, main_entries.provenience,
            main_entries.historical_evidence, main_entries.literature,
            main_entries.description, main_entries.appreciation
          )
          AGAINST (:terms IN BOOLEAN MODE)
        ) OR (
          MATCH(
            main_entries.title_reverse, main_entries.provenience_reverse,
            main_entries.historical_evidence_reverse, main_entries.literature_reverse,
            main_entries.description_reverse, main_entries.appreciation_reverse
          )
          AGAINST (:terms_reverse IN BOOLEAN MODE)
        ) OR (
          MATCH(
            ses.title, ses.description, ses.markings, ses.restaurations,
            ses.material,
            creator, dating, height, width, depth, diameter, weight,
            height_with_socket, width_with_socket, depth_with_socket, framing
          )
          AGAINST (:terms IN BOOLEAN MODE)
        ) OR (
          MATCH(
            ses.title_reverse, ses.description_reverse, ses.markings_reverse,
            ses.restaurations_reverse, ses.material_reverse,
            creator_reverse, dating_reverse, height_reverse, width_reverse,
            depth_reverse, diameter_reverse, weight_reverse,
            height_with_socket_reverse, width_with_socket_reverse,
            depth_with_socket_reverse, framing_reverse
          )
          AGAINST (:terms_reverse IN BOOLEAN MODE)
        ) OR (
          LOWER(tags.name) REGEXP :t
        ) OR (
          main_entries.sequence LIKE :simple
        ) OR (
          ses.sequence LIKE :simple
        ) OR (
          ses.location LIKE :simple
        ) OR (
          main_entries.location IN (:location_ids)
        )
      )",
      terms: terms.split(/\s+/).map{|t| "#{t}*"}.join(' '),
      terms_reverse: terms.split(/\s+/).map{|t| "+#{t.reverse}*"}.join(' '),
      t: "(\\||^)#{terms.downcase}(\\||$)",
      simple: "%#{terms}%",
      location_ids: matching_room_ids
    )
  }

  scope :include_unpublished, lambda { |value|
    value.present? ? all : where(publish: true)
  }

  def self.all_people
    select(:people).map{|v| v.people}.flatten
  end

  def people
    (self[:people] || '').split(/\s*;\s*/)
  end

  def people=(list)
    self[:people] = list.join('; ')
  end
end
