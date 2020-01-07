class AddPteScriptToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pte_script, :string
  end
end
