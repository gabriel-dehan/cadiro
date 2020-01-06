class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :item_type
      t.string :rarity
      t.string :image
      t.string :link
      t.text :wiki_item_card
      t.jsonb :stats
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
