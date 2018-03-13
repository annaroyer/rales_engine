class RemoveCreditCardExpirationDateFromTransactions < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :credit_card_expiration_date
  end
end
