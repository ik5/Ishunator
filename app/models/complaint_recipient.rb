# encoding: utf-8

require "email_validator.rb"

class ComplaintRecipient < ActiveRecord::Base
  belongs_to(:city)
  
  validates(:city_id, :description, :email, :recipient_type, :presence => true)
  validates(:email, :email => true)
  
  def as_json(options = {})
    return super.merge({ :recipient_type_name => self.recipient_type_name })
  end
  
  def recipient_type_name
    return RecipientTypes::Types[recipient_type]
  end
  
  class RecipientTypes
    TO = 0
    CC = 1
    BCC = 2
    
    Types = { TO => 'נמען', CC => 'עותק', BCC => 'עותק נסתר' }
  end
end
