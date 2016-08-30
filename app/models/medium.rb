class Medium < ApplicationRecord

  belongs_to :sub_entry

  has_attached_file :image, {
    url: '/media/:style/:id.:extension',
    storage: :filesystem,
    path: "#{Rails.root}/data/media/:style/:id.:extension",
    styles: {
      thumb: '80x80>',
      normal: '640x640>',
      big: '1440x1440>'
    },
    default_style: :normal
  }

  validates_attachment_content_type :image, :content_type => [
    "image/jpg", "image/jpeg", "image/png", "image/gif", 'image/tif',
    'image/tiff'
  ]

end
