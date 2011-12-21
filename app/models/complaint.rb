require "email_validator.rb"

class Complaint < ActiveRecord::Base
  belongs_to(:city)
  belongs_to(:business_type)
  
  validates(:city_id, :event_date, :business_type, :business_name, :business_address, :presence => true)
  validates(:statement_id, :numericality => { :only_integer => true, :greater_than_or_equal_to => 100000000, :less_than_or_equal_to => 999999999 }, :unless => Proc.new {|a| a.statement_id.blank? })
  validates(:statement_email, :email => true, :unless => Proc.new {|a| a.statement_email.blank? })
end
