class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.jsonb :currencies_prices

      t.timestamps
    end
  end
end
