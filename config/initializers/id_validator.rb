# Israeli ID validator

class ISRAELIIDValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    id_12_digits = [1, 2, 1, 2, 1, 2, 1, 2, 1]
    id_num       = value.to_s
    id_num       = '0' * (9 - id_num.to_s.length ) + id_num

    result       = 0
    0.step(8) do |i|
      num     = id_num[i,1].to_i * id_12_digits[i].to_i
      num     = (num / 10) + (num % 10) if (num >= 10)
      result += num
    end

    #return (result % 10  == 0)
    record.errors.add(attr_name, :statement_id, options.merge(:value => value)) if (result % 10  != 0)
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_israeli_id(*attr_names)
    validates_with ISRAELIIDValidator, _merge_attributes(attr_names)
  end
end
