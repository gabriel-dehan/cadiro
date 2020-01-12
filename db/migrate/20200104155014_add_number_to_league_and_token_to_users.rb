class AddNumberToLeagueAndTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string
    add_column :leagues, :version, :string
  end
end
