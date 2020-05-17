class ChangeCreditCardNumberToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :credit_card_number, :bigint, using: 'credit_card_number::bigint'
  end
end