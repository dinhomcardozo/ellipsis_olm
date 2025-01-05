class SubSegment < ApplicationRecord
    self.table_name = "sub_segments"
    belongs_to :segment
    belongs_to :company
    has_many :companies
end