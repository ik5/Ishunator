# encoding: utf-8

require 'aws/s3'

class Notifier < ActionMailer::Base
  default :from => "no-reply@avir-naki.com"
  
  default_url_options[:host] = 'furious-window-9057.herokuapp.com'
  
  layout 'mail'
  
  add_template_helper(HomeHelper)
  
  def confirm(complaint)
    @complaint = complaint
    
    return mail( :to => complaint.statement_email,
          :subject => "אישור תלונתך מספר #{complaint.to_param} בדבר עישון במקומות ציבוריים",
          :template_path => 'mailer',
          :template_name => 'confirm' )
  end
  
  def complaint(complaint)
    
    @complaint = complaint
    
    global_recipients = ComplaintRecipient.global_recipients
    
    recipients = global_recipients.concat( @complaint.city.complaint_recipients )
    
    to = recipients.select { |r| r.recipient_type == ComplaintRecipient::RecipientTypes::TO }.map(&:email)
    cc = recipients.select { |r| r.recipient_type == ComplaintRecipient::RecipientTypes::CC }.map(&:email)
    bcc = recipients.select { |r| r.recipient_type == ComplaintRecipient::RecipientTypes::BCC }.map(&:email)
    
    filename = "complaint_#{complaint.id}.pdf"
    
    attachments[filename] = generate_pdf(filename)
    
    @pdf_url = get_pdf_url(filename) # Set the url here so it doesn't show up in the generated pdf.
    
    return mail( :to => to,
          :cc => cc,
          :bcc => bcc,
          :subject => "תלונה בדבר עישון במקומות ציבוריים במקום #{@complaint.business_name}, #{@complaint.event_date.strftime("%d/%m/%Y")}",
          :template_path => 'mailer',
          :template_name => 'show' )

  end
  
private
  def generate_pdf(filename)
    
    pdf = render_to_string(:pdf => filename, :template => 'mailer/show.html.haml') 
    
    AWS::S3::Base.establish_connection!(:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'])
    
    AWS::S3::S3Object.store(filename, pdf, 'media.ishunator', :content_type => 'application/pdf', :access => :public_read)
    
    return pdf
    
  end
  
  def get_pdf_url(filename)
    AWS::S3::Base.establish_connection!(:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'])
    
    return AWS::S3::S3Object.url_for(filename, 'media.ishunator')
  end
end
