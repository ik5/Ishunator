class Admin::ComplaintRecipientsController < ApplicationController
  respond_to(:json, :html)
  
  DEFAULT_CITY = 227
  
  def index
    @recipients = ComplaintRecipient.where(:city_id => params[:city] || DEFAULT_CITY).order('recipient_type')
    
    respond_with(@recipients)
  end

  def create
    recipient = ComplaintRecipient.new(params[:complaint_recipient])
    
    saved = @complaint.save!
    
    respond_with(saved || @complaint.errors.full_messages, :status => (saved ? :ok : 422))
  end

  def destroy
    recipients = [* ComplaintRecipient.find(params[:id]) ]
    
    recipients.each do |cr|
      cr.destroy
    end
    
    respond_with(recipients)
  end

  def update
    recipient = ComplaintRecipient.find(params[:id])
    
    recipient.update_attribues(params[:complaint_recipient])
    
    respond_with(recipient)
  end

end
