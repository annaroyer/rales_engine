class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    order('RANDOM()').first
  end

  def price
    number_to_currency(self.unit_price.to_f / 100)
  end
end
