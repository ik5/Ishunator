# encoding: utf-8

require "email_validator.rb"

class ComplaintRecipient < ActiveRecord::Base
  belongs_to(:city)

  validates(:description, :email, :recipient_type, :presence => true)
  validates(:email, :email => true)

  scope :global_recipients, where(:city_id => nil)

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

    Types = { TO => I18n.t('to'), CC =>  I18n.t('cc'), BCC => I18n.t('bcc') }
  end
end
