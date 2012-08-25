class Admin::ComplaintRecipientsController < Admin::AdminController
  respond_to(:html, :only => [ :index ])
  respond_to(:json, :except => [ :index ])

  DEFAULT_CITY = 227

  def index
    @recipients = ComplaintRecipient.where(:city_id => params[:city] || DEFAULT_CITY).order('recipient_type')

    @global_recipients = ComplaintRecipient.where(:city_id => nil).order('recipient_type')

    respond_with(@recipients)
  end

  def create
    recipient = ComplaintRecipient.new(params[:complaint_recipient])

    if recipient.valid? && recipient.save
      respond_with(recipient, :status => :ok, :location => admin_recipients_path)
    else
      respond_with(recipient.errors.full_messages, :status => :unprocessable_entity, :location => nil)
    end
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
