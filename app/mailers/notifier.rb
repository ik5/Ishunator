# encoding: utf-8

class Notifier < ActionMailer::Base
  default :from => "no-reply@avir-naki.com"
  
  layout 'mail'
  
  add_template_helper(HomeHelper)
  
  def complaint(complaint)
    
    @complaint = complaint
    
    global_recipients = ComplaintRecipient.global_recipients
    
    recipients = global_recipients.concat( @complaint.city.complaint_recipients )
    
    to = recipients.select { |r| r.recipient_type == ComplaintRecipient::RecipientTypes::TO }.map(&:email)
    cc = recipients.select { |r| r.recipient_type == ComplaintRecipient::RecipientTypes::CC }.map(&:email)
    bcc = recipients.select { |r| r.recipient_type == ComplaintRecipient::RecipientTypes::BCC }.map(&:email)
    
    return mail( :to => to,
          :cc => cc,
          :bcc => bcc,
          :subject => "תלונה בדבר עישון במקומות ציבוריים במקום #{@complaint.business_name}, #{@complaint.event_date.strftime("%d/%m/%Y")}",
          :template_path => 'mailer',
          :template_name => 'show' )

  end
end
