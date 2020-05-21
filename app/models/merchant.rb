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
end