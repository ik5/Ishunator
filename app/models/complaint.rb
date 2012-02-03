require "email_validator.rb"

class Complaint < ActiveRecord::Base
  belongs_to(:city)
  belongs_to(:business_type)
  
  has_attached_file(:smoking_image1, :styles => { :thumbnail => '120x80>', :normal => '800x600>'})
  has_attached_file(:smoking_image2, :styles => { :thumbnail => '120x80>', :normal => '800x600>'})
  has_attached_file(:smoking_image3, :styles => { :thumbnail => '120x80>', :normal => '800x600>'})
  
  validates(:statement_email, :statement_full_name, :statement_id, :city_id, :event_date, :business_type, :business_name, :business_address, :presence => true)
  validates(:statement_id, :numericality => { :only_integer => true, :greater_than_or_equal_to => 100000000, :less_than_or_equal_to => 999999999 })
  validates(:statement_email, :email => true)
end
