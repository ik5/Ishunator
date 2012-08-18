# encoding: utf-8

module HomeHelper
  def must_pass_through(complaint)
    must_pass_through = []
    must_pass_through << t('enter_public') if complaint.smoking_room_must_pass_through_to_public_area
    must_pass_through << t('arrive_places') if complaint.smoking_room_must_pass_through_to_bathroom
    must_pass_through << t('arrive_elsewhere', :list => complaint.smoking_room_must_pass_through_to_other) unless complaint.smoking_room_must_pass_through_to_other.blank?

    return must_pass_through.join(', ')
  end

  def business_details(complaint)
    business_details = [complaint.business_name]

    if complaint.private_company_number.present? || complaint.business_number.present?
      business_numbers = []
      business_numbers << t('private_company', :number => complaint.private_company_number) if complaint.private_company_number.present?
      business_numbers << t('norma_business', :number => complaint.business_number) if complaint.business_number.present?

      business_details << "(#{business_numbers.join(',')})" unless business_numbers.empty?
    end

    return business_details.join(' ')
  end

end
