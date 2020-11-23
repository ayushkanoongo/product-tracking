class Item < ApplicationRecord

    validates :serial_number, presence: true
    belongs_to :product, optional: true

    enum status: { No: 0, Yes: 1 }
    
end
