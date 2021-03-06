# encoding: utf-8

class Notifier < ActionMailer::Base
  default :from => "no-reply@avir-naki.com"

  default_url_options[:host] = 'furious-window-9057.herokuapp.com'

  layout 'mail'

  add_template_helper(HomeHelper)

  def confirm(complaint)
    @complaint = complaint

    filename = "complaint_#{complaint.to_param}.pdf"

    attachments[filename] = generate_pdf(filename)

    return mail( :to => complaint.statement_email,
          :subject => t('subject', :number => complaint.to_param),
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

    filename = "complaint_#{complaint.to_param}.pdf"

    attachments[filename] = generate_pdf(filename)

    return mail( :to => to,
          :from => complaint.statement_email,
          :cc => cc,
          :bcc => bcc,
          :subject => t('subject2', :number => @complaint.business_name, :date => @complaint.event_date.strftime("%d/%m/%Y")),
          :template_path => 'mailer',
          :template_name => 'show' )

  end

private
  def generate_pdf(filename)

    pdf = render_to_string(:pdf => filename, :template => 'home/show.html.haml', :layout => 'pdf.html.haml', :encoding => 'UTF-8')

    return WickedPdf.new.pdf_from_string(pdf)

  end
end
