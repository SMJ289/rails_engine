class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.find_by_name(query)
    find_by("lower(name) like ?", "%#{query.downcase}%")
  end
end