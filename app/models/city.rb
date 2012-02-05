class City < ActiveRecord::Base
  has_many(:complaints)
  has_many(:complaint_recipients)
end