# encoding: utf-8

class HomeController < ApplicationController
  
  respond_to(:pdf, :html, :only => :show)
  
  def index
    
  end
  
  def new
    @complaint = Complaint.new
  end
  
  def create
    complaint_images = params[:complaint].delete(:complaint_images)
    
    @complaint = Complaint.new(params[:complaint])
    
    complaint_images.each do |image|
      @complaint.complaint_images.build({ :image => image })
    end if complaint_images
    
    # Temporary change for the pilot.
    @complaint.city_id = 227
    
    if @complaint.valid? && @complaint.save
      
      # Moved to model.
      #Notifier.complaint(@complaint).deliver unless @complaint.city.complaint_recipients.empty?
      
      redirect_to( thankyou_complaint_path(@complaint) )
    else
      render(:action => :new)
    end
  end
  
  def thankyou
    @id = params[:id]
    
    @complaint = Complaint.find_by_id( Hideous.bare( @id ) ) || not_found
  end
  
  def confirm
    confirmation_token = params[:confirmation_token]
    
    @complaint = Complaint.find_by_confirmation_token(confirmation_token) || not_found
    
    @complaint.confirm
    
    @recipients = (ComplaintRecipient.global_recipients + @complaint.city.complaint_recipients).reject {|r| r.recipient_type == ComplaintRecipient::RecipientTypes::BCC }
  end

  def show
    @id = params[:id]
    
    @complaint = Complaint.joins(:city, :business_type).find_by_id( Hideous.bare( @id ) ) || not_found
    
    respond_with(@complaint) do |format|
      format.pdf do
        filename = "complaint_#{@complaint.to_param}.pdf"
        
        pdf = render_to_string(:pdf => filename, :template => 'home/show.html.haml', :layout => 'pdf.html.haml', :encoding => 'UTF-8') 
    
        send_data(pdf, :filename => filename, :type => :pdf)
      end
    end
  end

end
