require "email_validator.rb"

class Complaint < ActiveRecord::Base
  belongs_to(:city)
  belongs_to(:business_type)
  
  has_many(:complaint_images)
  
  validates(:statement_email, :statement_full_name, :statement_id, :city_id, :event_date, :business_type, :business_name, :business_address, :smoking_comment, :presence => true)
  validates(:statement_id, :numericality => { :only_integer => true, :greater_than_or_equal_to => 100000000, :less_than_or_equal_to => 999999999 })
  validates(:statement_email, :email => true)
  validates(:private_company_number, :format => { :with => /^51[\d-]{7,}$/ }, :allow_blank => true)
  validates(:business_number, :format => { :with => /^[\d-]{9,}$/ }, :allow_blank => true)

end
