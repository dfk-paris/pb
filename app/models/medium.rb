class Medium < ApplicationRecord

  belongs_to :sub_entry

  has_attached_file :image, {
    url: '/media/:style/:id/',
    storage: :filesystem,
    path: "#{Rails.root}/data/media",
    styles: {
      thumb: '80x80>',
      normal: '640x640>',
      big: '1440x1440>'
    },
    default_style: :normal
  }

  styles: {

  }

end
