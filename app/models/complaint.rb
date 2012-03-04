require 'email_validator.rb'
require 'hideous.rb'

class Complaint < ActiveRecord::Base
  belongs_to(:city)
  belongs_to(:business_type)
  
  has_many(:complaint_images)
  
  validates(:statement_email, :statement_full_name, :statement_id, :city_id, :event_date, :business_type, :business_name, :business_address, :smoking_comment, :presence => true)
  validates(:statement_id, :format => { :with => /^\d{9,10}$/ })
  validates(:statement_email, :email => true)
  validates(:private_company_number, :format => { :with => /^51[\d-]{7,}$/ }, :allow_blank => true)
  validates(:business_number, :format => { :with => /^[\d-]{9,}$/ }, :allow_blank => true)
  validate(:event_date_valid)

  self.per_page = 25
  
  after_create do
    Notifier.complaint(self).deliver unless self.city.complaint_recipients.empty? && ComplaintRecipient.global_recipients.empty?
  end
  
  def to_param
    return Hideous.hide( id )
  end
  
  def event_date_valid
    errors.add(:event_date, I18n.t('activerecord.errors.messages.cannot_be_in_the_future')) if event_date > Time.now.tomorrow.to_date
  end

end