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

class User < ActiveRecord::Base
  attr_accessible :account_number, :address, :email, :fname, :lname, :phone_number
  has_many :readings

  before_save {|user| user.email = email.downcase}

  validates :fname, presence: true
  validates :account_number, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates_length_of :account_number, :is => 8, :message => "should be of 8 digits"
  validates_numericality_of :account_number, :only_integer => true

end
