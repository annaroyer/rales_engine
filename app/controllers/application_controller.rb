class ApplicationController < ActionController::API

  def merchant_revenue(dollars)
    '%.2f' % (dollars.to_f / 100)
  end
end
