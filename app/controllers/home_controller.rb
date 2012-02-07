class HomeController < ApplicationController
  
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
    end
    
    # Temporary change for the pilot.
    @complaint.city_id = 227
    
    if @complaint.valid? && @complaint.save
      
      Notifier.complaint(@complaint).deliver
      
      redirect_to(:action => :thankyou, :id => @complaint.id)
    else
      render(:action => :index)
    end
  end
  
  def thankyou
    @complaint = Complaint.find_by_id(params[:id]) || not_found
  end

  def view
    @complaint = Complaint.joins(:city, :business_type).find_by_id(params[:id]) || not_found
    
    @must_pass_through = []
    @must_pass_through << "להיכנס למקום הציבורי" if @complaint.smoking_room_must_pass_through_to_public_area
    @must_pass_through << "להגיע לשירותים" if @complaint.smoking_room_must_pass_through_to_bathroom
    @must_pass_through << "להגיע למקום אחר: #{@complaint.smoking_room_must_pass_through_to_other}" unless @complaint.smoking_room_must_pass_through_to_other.blank?
  end

end
