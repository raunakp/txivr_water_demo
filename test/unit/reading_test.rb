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

require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
