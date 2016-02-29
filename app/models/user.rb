class User < ActiveRecord::Base
  has_many :consumptions
  has_many :drugs, through: :consumptions
end
