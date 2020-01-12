require 'open-uri'

class Item < ApplicationRecord
  validates :name, presence: true
  validates :item_type, presence: true
  validates :name, uniqueness: { scope: :item_type, message: "Item already exists" }

  after_create :fetch_wiki_data

  has_many :analyses, dependent: :destroy
  has_many :league_analyses, through: :analyses

  def slug
    name.parameterize
  end

  private
  def fetch_wiki_data
    # Only works for uniquest for now
    result = PoeWikiApi.search_unique(name)
    item_data = result["cargoquery"][0]
    if item_data
      item = item_data["title"]
      icon_name = item["inventory icon"]
      
      icon_url = PoeWikiApi.fetch_icon_url(icon_name)

      self.image = icon_url      
      self.name = item["name"] # Ensure consistent name with wiki
      self.link = URI.encode("https://pathofexile.gamepedia.com/#{self.name}")
      self.rarity = item["rarity"]
      self.tags = item["tags"].split(",").reject { |v| ["default"].include?(v) }
      generate_wiki_item_card
      
      self.save!
    else
      raise "Item data couldn't be found"
    end
  end

  # Only works for uniquest for now
  def generate_wiki_item_card
    begin 
      dom = Nokogiri::HTML(open(self.link))
    rescue 
      raise "Wiki link invalid"
    end
    
    item_card = dom.css('.infobox-page-container .item-box.-unique').first
    if item_card
      self.wiki_item_card = item_card.to_s
    end
  end
end
