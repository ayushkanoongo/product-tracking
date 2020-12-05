class Product < ApplicationRecord
	paginates_per 15

	include PgSearch::Model
	pg_search_scope :search_by_serial, associated_against: {
		items: [:serial_number]
	}

	pg_search_scope :search_by_name, against: :patient_name

	has_many :items, dependent: :destroy
	accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank

	# validates :serial_number, presence: true
	validates :mobile,:presence => true,
                 :numericality => true,
				 :length => { :minimum => 10, :maximum => 10 }
				 
	def items_status
		status_array = self.items.map(&:status)
		if status_array.include?("No")
			"Rented"
		else
			"Received"
		end
	end
end
