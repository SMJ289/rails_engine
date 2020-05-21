class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_by_params(query_params)
    sql_query = self.sql_query(query_params)
    sql_params = self.sql_params(query_params)
    find_by(sql_query, sql_params)
  end

  def self.find_all_by_params(query_params)
    sql_query = self.sql_query(query_params)
    sql_params = self.sql_params(query_params)
    where(sql_query, sql_params)
  end

  def self.sql_query(query_params)
    params = []
    params << "lower(name) like :name" if query_params['name'].present?
    params << "lower(description) like :description" if query_params['description'].present?
    params << "unit_price = :unit_price" if query_params['unit_price'].present?
    params.join(" AND ")
  end

  def self.sql_params(query_params)
    conditions = {}
    conditions[:name] = "%#{query_params['name'].downcase}%" if query_params['name'].present?
    conditions[:description] = "%#{query_params['description'].downcase}%" if query_params['description'].present?
    conditions[:unit_price] = query_params['unit_price'] if query_params['unit_price'].present?
    conditions
  end
end
