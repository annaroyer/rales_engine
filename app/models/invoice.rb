class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  def find_relationship(resource)
    
  end
end
