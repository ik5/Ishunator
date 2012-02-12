module HomeHelper
  def must_pass_through(complaint)
    must_pass_through = []
    must_pass_through << "להיכנס למקום הציבורי" if complaint.smoking_room_must_pass_through_to_public_area
    must_pass_through << "להגיע לשירותים" if complaint.smoking_room_must_pass_through_to_bathroom
    must_pass_through << "להגיע למקום אחר: #{complaint.smoking_room_must_pass_through_to_other}" unless complaint.smoking_room_must_pass_through_to_other.blank?
    
    return must_pass_through.join(', ')
  end
  
  def business_details(complaint)
    business_details = [complaint.business_name]
    
    if complaint.private_company_number.present? || complaint.business_number.present?
      business_numbers = []
      business_numbers << "ח.פ: #{complaint.private_company_number}" if complaint.private_company_number.present?
      business_numbers << "ע.מ: #{complaint.business_number}" if complaint.business_number.present?
      
      business_details << "(#{business_numbers.join(',')})" unless business_numbers.empty?
    end
    
    return business_details.join(' ')
  end
  
end
