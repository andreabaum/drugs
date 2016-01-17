class Drug < ActiveRecord::Base
  has_many :purchases
end
