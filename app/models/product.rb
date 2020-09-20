class Product < ApplicationRecord
	paginates_per 25

	include PgSearch::Model
	pg_search_scope :search_by_serial_number, against: :serial_number

	enum status: [ :Rented, :Received ]

	validates :serial_number, presence: true
	validates :mobile,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 10 }
end
