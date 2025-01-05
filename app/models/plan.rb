class Plan < ApplicationRecord
    self.table_name = "plans"
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    
    has_many :clients
    belongs_to :system_admins
end
