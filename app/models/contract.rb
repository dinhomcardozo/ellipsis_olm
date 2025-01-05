class Contract < ApplicationRecord
    self.table_name = "contracts"
    belongs_to :opportunity
    belongs_to :company
    has_many :opportunities
  
    private
  
    def update_products
      self.products = opportunity.clients_products.pluck(:id) if opportunity.present?
    end
  
  end