class Grupo < ApplicationRecord
end

class CreateGrupos < ActiveRecord::Migration[5.1]
  def change
    create_table :grupos do |t|
      t.string :nome, null: false, default: 'G1'

      t.timestamps
    end

  	Grupo.create([
		{nome: "G1"},
		{nome: "G2"},
		{nome: "G3"},
		{nome: "G4"}
	])
  end

end
