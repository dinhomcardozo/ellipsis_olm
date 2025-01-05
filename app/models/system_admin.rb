class SystemAdmin < ApplicationRecord
    self.table_name = "system_admins"
    has_secure_password
    has_many :clients, dependent: :destroy
end