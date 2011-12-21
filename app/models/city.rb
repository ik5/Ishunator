class City < ActiveRecord::Base
  has_many(:complaints)
end
