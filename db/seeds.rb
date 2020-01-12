require 'poe_watch'

KNOWN_LEAGUES_VERSIONS = {
  "Metamorph" => "3.9",
  "Blight" => "3.8",
  "Legion" => "3.7",
  "Synthesis" => "3.6",
  "Betrayal" => "3.5",
  "Delve" => "3.4",
  "Incursion" => "3.3",
  "Bestiary" =>	"3.2",
  "Abyss" => "3.1",
  "Harbinger" =>	"3.0",
  "Legacy" =>	"2.6",
  "Breach" =>	"2.5"
}

User.destroy_all
User.create({ email: 'test@test.com', password: 'password' });

puts "Fetching poe watch data..."
PoeWatch::Api.refresh!(3600 * 24)
puts "Fetched!"

League.destroy_all
puts "Creating Leagues..."
PoeWatch::League.all.each do |league|
  if !league.event
    league_version_data = KNOWN_LEAGUES_VERSIONS.find { |name, version| league.name.match(Regexp.new(name)) }
    League.create({
      name: league.name,
      display: league.display,
      hardcore: league.hardcore,
      active: league.active,
      start_date: league.start,
      end_date: league.end,
      version: league_version_data ? league_version_data.last : nil
    })
  end
end