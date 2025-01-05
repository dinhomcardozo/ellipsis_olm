class Group < ApplicationRecord
    self.table_name = "groups"   
    belongs_to :client
    has_many :companies
  end