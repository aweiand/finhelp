class CreateExtracaos < ActiveRecord::Migration[5.1]
	def change
		create_table :extracaos do |t|
			t.integer :agenciaug, default: 694
		    t.date 	  :data
		    t.integer :sequencialdata, default: 1
		    t.integer :sequencial, default: 1
		    t.integer :ug, default: 158327
		    t.string  :operador
			t.string  :tipodh
			t.date    :dataemissao
			t.date    :datavencimento
			t.string  :observacao
			t.string  :processodh
			t.date    :dataateste
			t.string  :credor
			t.date    :datapagamento
			t.date    :dtemissaodocorigem
			t.string  :numerodocorigem
			t.string  :situacao, default: "DSP061"
			t.string  :empenho
			t.integer :valor
			t.integer :contavpd
			t.string  :centrodecusto
			t.integer :mes
			t.integer :ano
			t.integer :codigosiorg
			t.string  :tipoob
			t.string  :banco
			t.string  :agencia
			t.string  :contafavorecido
			t.string  :contapagadora, default: "UNICA"

			t.timestamps
		end
	end
end
