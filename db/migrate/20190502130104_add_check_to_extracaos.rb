class AddCheckToExtracaos < ActiveRecord::Migration[5.1]
  def change
  	add_column :extracaos, :visto, :boolean, null: false, default: false
  end
end
