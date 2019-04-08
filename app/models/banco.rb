class Banco < ApplicationRecord
	default_scope { order("codigo ASC") }

	def fullname
		"#{self.codigo} - #{self.nome}"
	end
end
