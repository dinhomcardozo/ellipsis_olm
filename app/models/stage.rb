class Stage < ApplicationRecord #README-Stages&Opportunities.md
    self.table_name = "stages"
    has_many :opportunities, dependent: :nullify
    validates :description, presence: true
    validates :position, presence: true, uniqueness: true

    # enum stage: { prospects: 0, lead: 1, demonstration: 2, quote: 3, sale: 4, loss_sale: 5, post_sales: 6, about_to_renew: 7, renewed: 8, not_renewed: 9 }
end