class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_by_name(query)
    find_by("lower(name) like ?", "%#{query.downcase}%")
  end

  def self.find_all_by_name(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end

  def self.find_by_description(query)
    find_by("lower(description) like ?", "%#{query.downcase}%")
  end

  def self.find_all_by_description(query)
    where("lower(description) like ?", "%#{query.downcase}%")
  end
end