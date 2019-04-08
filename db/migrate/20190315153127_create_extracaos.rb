class CreateExtracaos < ActiveRecord::Migration[5.1]
	def change
		create_table :extracaos do |t|
			t.integer :agenciaug, default: 694, null: false
		    t.date 	  :data, null: false
		    t.integer :sequencial, default: 1, null: false
		    t.integer :ug, default: 158327, null: false
		    t.string  :operador, null: false
			t.string  :tipodh
			t.date    :dataemissao
			t.date    :datavencimento
			t.string  :observacao
			t.string  :processodh
			t.date    :dataateste
			t.string  :credor, null: false
			t.date    :datapagamento
			t.date    :dtemissaodocorigem
			t.string  :numerodocorigem
			t.string  :situacao, default: "DSP061", null: false
			t.string  :empenho, null: false
			t.integer :valor
			t.integer :contavpd
			t.string  :centrodecusto
			t.integer :mes, null: false
			t.integer :ano, null: false
			t.integer :codigosiorg, null: false
			t.string  :tipoob
			t.string  :banco, default: "0", null: false
			t.string  :agencia, default: "0", null: false
			t.string  :contafavorecido, default: "0", null: false
			t.string  :contapagadora, default: "UNICA"

			t.timestamps
		end
	end
end
