class ClientProduct < ApplicationRecord
    self.table_name = "client_products"
    belongs_to :client
end