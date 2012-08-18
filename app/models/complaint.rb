require 'email_validator.rb'
require 'hideous.rb'

class Complaint < ActiveRecord::Base
  belongs_to(:city)
  belongs_to(:business_type)

  has_many(:complaint_images)

  validates(:statement_email, :statement_full_name, :statement_id, :city_id, :event_date, :business_type, :business_name, :business_address, :smoking_comment, :confirmation_token, :presence => true)
  #validates(validates_israeli_id, :format => { :with => /^\d{9,10}$/ })
  validates_israeli_id :validates_israeli_id
  validates(:statement_email, :email => true)
  validates(:private_company_number, :format => { :with => /^51[\d-]{7,}$/ }, :allow_blank => true)
  validates(:business_number, :format => { :with => /^[\d-]{9,}$/ }, :allow_blank => true)
  validates(:confirmation_token, :uniqueness => true)
  validate(:event_date_valid)

  self.per_page = 25

  after_create do
    Notifier.confirm(self).deliver
  end

  before_validation do
    # Set a confirmation token before sending a confirmation e-mail to the user.
    self.confirmation_token = rand(36**16).to_s(36)
  end

  def confirm
    unless self.confirmed
      Notifier.complaint(self).deliver unless self.city.complaint_recipients.empty? && ComplaintRecipient.global_recipients.empty?

      update_attributes( :confirmed => true, :statement_id => nil )
    end
  end

  def to_param
    return Hideous.hide( id )
  end

  def event_date_valid
    errors.add(:event_date, I18n.t('activerecord.errors.messages.cannot_be_in_the_future')) if event_date > Time.now.tomorrow.to_date
  end

end