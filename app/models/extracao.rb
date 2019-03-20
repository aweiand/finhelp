class Extracao < ApplicationRecord

	validates :credor, :cpf => true, :allow_blank => false, :allow_nil => false	
	validates :operador, :cpf => true, :allow_blank => false, :allow_nil => false	
	validates_length_of :agenciaug, allow_blank: false, allow_nil: false, :minimum => 3
	validates_length_of :data, allow_blank: false, allow_nil: false, :minimum => 8
	validates_length_of :sequencialdata, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :sequencial, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :ug, allow_blank: false, allow_nil: false, :minimum => 6
	validates_length_of :tipodh, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :dataemissao, allow_blank: false, allow_nil: false, :minimum => 8
	validates_length_of :datavencimento, allow_blank: false, allow_nil: false, :minimum => 8
	validates_length_of :observacao, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :processodh, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :dataateste, allow_blank: false, allow_nil: false, :minimum => 8
	validates_length_of :datapagamento, allow_blank: false, allow_nil: false, :minimum => 8
	validates_length_of :dtemissaodocorigem, allow_blank: false, allow_nil: false, :minimum => 8
	validates_length_of :numerodocorigem, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :situacao, allow_blank: false, allow_nil: false, :minimum => 6
	validates_length_of :empenho, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :valor, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :contavpd, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :centrodecusto, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :mes, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :ano, allow_blank: false, allow_nil: false, :minimum => 4
	validates_length_of :codigosiorg, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :tipoob, allow_blank: false, allow_nil: false, :minimum => 3
	validates_length_of :banco, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :agencia, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :contafavorecido, allow_blank: false, allow_nil: false, :minimum => 1
	validates_length_of :contapagadora, allow_blank: false, allow_nil: false, :minimum => 1

end
