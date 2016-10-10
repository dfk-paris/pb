class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.pageit(page, per_page = 10)
    if per_page == 'all'
      all
    else
      page = [(page || 1).to_i, 1].max - 1
      per_page = 10
      limit(per_page).offset(per_page * page)
    end
  end
end
