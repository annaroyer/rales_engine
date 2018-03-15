class RevenueMerchantSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    '%.2f' % (object.revenue.to_f / 100)
  end
end
