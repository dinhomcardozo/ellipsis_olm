class Opportunity < ApplicationRecord
    self.table_name = "opportunities"
    has_one :contact
    belongs_to :user
    belongs_to :stage
    belongs_to :client
    has_many :clients_products
    has_one :contract
  
    # enum stage: { prospects: 0, lead: 1, demonstration: 2, quote: 3, sale: 4, loss_sale: 5, post_sales: 6, about_to_renew: 7, renewed: 8, not_renewed: 9 }
  
    validates :contact, :user, :stage, :client, presence: true
    validates :client_product, presence: true
  
    def move_to_stage(new_stage)
      update(stage: new_stage)
    end
  
  end