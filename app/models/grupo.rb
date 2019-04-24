class Grupo < ApplicationRecord
	default_scope { order("nome ASC") }

	has_many :extracaos	
end
