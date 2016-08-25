class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :pageit, lambda { |page|
    page = [(page || 1).to_i, 1].max - 1
    per_page = 10
    limit(per_page).offset(per_page * page)
  }
end
