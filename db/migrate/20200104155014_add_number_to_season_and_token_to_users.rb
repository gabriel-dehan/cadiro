class AddNumberToSeasonAndTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string
    add_column :seasons, :version, :string
  end
end
