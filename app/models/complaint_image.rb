class ComplaintImage < ActiveRecord::Base
  belongs_to(:complaint)
  
  has_attached_file(:image, :styles => { :thumbnail => ['120x80>', :jpg], :normal => ['800x600>', :jpg] })
  
  validates_attachment_presence(:image)
  validates_attachment_content_type(:image, :content_type => ['image/png', 'image/x-png', 'image/jpg', 'image/jpeg', 'image/pjpeg'])
  validates_attachment_size(:image, :in => 1..5.megabyte)
end