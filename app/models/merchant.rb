class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_by_name(query)
    find_by("lower(name) like ?", "%#{query.downcase}%")
  end

  def self.find_all_by_name(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end

  def self.find_most_revenue(limit)
    joins(:invoice_items, :transactions)
    .where(transactions: {result:'success'})
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id).order('revenue DESC')
    .limit(limit)
  end

  def self.most_items_sold(limit)
    joins(:invoice_items, :transactions)
    .where(transactions: {result:'success'})
    .select('merchants.*, sum(invoice_items.quantity) as total_items')
    .group(:id).order('total_items DESC')
    .limit(limit)
  end
end