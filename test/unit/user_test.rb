# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  phone_number   :string(255)
#  fname          :string(255)
#  lname          :string(255)
#  email          :string(255)
#  address        :string(255)
#  account_number :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
