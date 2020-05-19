require 'csv'

desc "Seed database with csv files"
task :import => [:environment] do
  Rake::Task['db:reset'].invoke

  CSV.foreach('lib/seeds/customers.csv', headers: true) do |row|
    Customer.create(row.to_h)
  end
  
  CSV.foreach('lib/seeds/merchants.csv', headers: true) do |row|
    Merchant.create(row.to_h)
  end
  
  CSV.foreach('lib/seeds/items.csv', headers: true) do |row|
    Item.create(name: row['name'],
                description: row['description'],
                unit_price: row['unit_price'].to_f/100,
                merchant_id: row['merchant_id'],
                created_at: row['created_at'],
                updated_at: row['updated_at']
    )
  end
  
  CSV.foreach('lib/seeds/invoices.csv', headers: true) do |row|
    Invoice.create(row.to_h)
  end

  CSV.foreach('lib/seeds/invoice_items.csv', headers: :true) do |row|
    InvoiceItem.create(quantity: row['quantity'],
                       unit_price: row['unit_price'].to_f/100,
                       item_id: row['item_id'],
                       invoice_id: row['invoice_id'],
                       created_at: row['created_at'],
                       updated_at: row['updated_at']
    )
  end

  CSV.foreach('lib/seeds/transactions.csv', headers: true) do |row|
    Transaction.create(row.to_h)
  end

  ActiveRecord::Base.connection.reset_pk_sequence!('items')
  ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
end
