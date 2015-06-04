class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :pic,
      processors: [:watermark],
      styles: {
        medium: {
          geometry: "800x800>",
          watermark_path: "#{Rails.root}/public/images/watermark_corner.png",
          big_watermark_path: "#{Rails.root}/public/images/watermark_center.png",
          auto_orient: false
        },
        thumb: {
          geometry: "300x300>",
          watermark_path: "#{Rails.root}/public/images/watermark_corner.png",
          auto_orient: false
        },
        list: "100x70>"
      },
    default_url: "/images/:style/missing.png"
end
