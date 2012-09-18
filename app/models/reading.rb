class Reading < ActiveRecord::Base
  attr_accessible :meter_reading, :user_id
  belongs_to :user
end
