class User < ActiveRecord::Base
  attr_accessible :account_number, :address, :email, :fname, :lname, :phone_number
  has_many :readings
end
