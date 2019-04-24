class Grupo < ApplicationRecord
end

class AddGrupoToExtracaos < ActiveRecord::Migration[5.1]
  def change
    add_reference :extracaos, :grupo, foreign_key: true, null: false, default: Grupo.first.id
  end
end
