class Client < ApplicationRecord
  self.table_name = "clients"
  belongs_to :system_admin, class_name: 'SystemAdmin', foreign_key: 'system_admin_id'
  has_many :users
  has_many :groups
  has_many :clients_products
  has_one :plan
end