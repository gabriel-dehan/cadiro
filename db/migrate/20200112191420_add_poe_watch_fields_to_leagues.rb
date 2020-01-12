class AddPoeWatchFieldsToLeagues < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :display, :string
    add_column :leagues, :hardcore, :boolean
    add_column :leagues, :active, :boolean
  end
end
