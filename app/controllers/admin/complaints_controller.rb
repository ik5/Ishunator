class Admin::ComplaintsController < Admin::AdminController
  respond_to(:html, :json)
  
  def index
    @complaints = Complaint.includes(:city, :business_type).page(params[:page]).order('id DESC')
    
    respond_with(@complaints)
  end
end