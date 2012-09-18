# == Schema Information
#
# Table name: readings
#
#  id            :integer          not null, primary key
#  meter_reading :string(255)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Reading < ActiveRecord::Base
  attr_accessible :meter_reading, :user_id
  belongs_to :user
end
