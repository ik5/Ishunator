# encoding: utf-8

require "email_validator.rb"

class ComplaintRecipient < ActiveRecord::Base
  belongs_to(:city)
  
  validates(:city_id, :description, :email, :recipient_type, :presence => true)
  validates(:email, :email => true)
  
  class RecipientTypes
    TO = 0
    CC = 1
    BCC = 2
    
    Types = { TO => 'נמען', CC => 'עותק', BCC => 'עותק נסתר' }
  end
end