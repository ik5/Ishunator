# encoding: utf-8

class Notifier < ActionMailer::Base
  default :from => "no-reply@avir-naki.com"
  
  layout :mail
  
  add_template_helper(HomeHelper)
  
  def complaint(complaint)
    
    @complaint = complaint
    
    global_recipients = ComplaintRecipient.global_recipients
    
    recipients = @complaint.city.complaint_recipients.concat( global_recipients )
    
    return mail( :to => recipients.select { |recipient| recipient.recipient_type == ComplaintRecipient::RecipientTypes::TO }.map(&:email),
          :cc => recipients.select { |recipient| recipient.recipient_type == ComplaintRecipient::RecipientTypes::CC }.map(&:email),
          :bcc => recipients.select { |recipient| recipient.recipient_type == ComplaintRecipient::RecipientTypes::BCC }.map(&:email),
          :subject => "תלונה בדבר עישון במקומות ציבוריים במקום #{@complaint.business_name}, #{@complaint.event_date.strftime("%d/%m/%Y")}",
          :template_path => 'home',
          :template_name => 'show' )

  end
end
