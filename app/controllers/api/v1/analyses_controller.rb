class Api::V1::AnalysesController < Api::V1::APIController 
  def data
    @prms ||= {
      "search" => {
        "type" => "search", 
        "league" => "Metamorph", 
        "query" => {
          "status" => {
            "option" => "online"
          }, 
          "name" => "Circle of Nostalgia", 
          "type" => "Amethyst Ring", 
          "stats" => [{
            "type" => "and",
            "filters" => [{
              "id" => "explicit.stat_4253105373",
              "value" => {
                "min" => 50
              },
              "disabled" => false,
              "data" => {
                "id" => "explicit.stat_4253105373", "text" => "Herald of Agony has #% reduced Mana Reservation", "type" => "explicit"
              }
            }],
            "disabled" => false
          }], 
          "filters" => {
            "misc_filters" => {
              "filters" => {
                "ilvl" => {
                  "max" => nil, "min" => 80
                }, "quality" => {
                  "max" => 20, "min" => 1
                }, "corrupted" => {
                  "option" => "false"
                }, "enchanted" => {
                  "option" => "true"
                }, "gem_level" => {
                  "max" => 1, "min" => 1
                }, "identified" => {
                  "option" => "false"
                }, "shaper_item" => {
                  "option" => "true"
                }
              }, "disabled" => false
            }, "type_filters" => {
              "filters" => {
                "category" => {
                  "option" => "accessory.ring"
                }
              }, "disabled" => false
            }, "trade_filters" => {
              "filters" => {
                "price" => {
                  "max" => 3, "min" => 1, "option" => "exa"
                }
              }, "disabled" => false
            }, "armour_filters" => {
              "filters" => {
                "ar" => {
                  "max" => nil, "min" => 1
                }, "es" => {
                  "max" => nil, "min" => 1
                }, "ev" => {
                  "max" => nil, "min" => 1
                }, "block" => {
                  "max" => nil, "min" => 1
                }
              }, "disabled" => false
            }, "socket_filters" => {
              "filters" => {
                "links" => {
                  "a" => nil, "b" => nil, "d" => nil, "g" => nil, "r" => nil, "w" => nil, "max" => 6, "min" => 1
                }, "sockets" => {
                  "a" => nil, "b" => 1, "d" => nil, "g" => 1, "r" => 1, "w" => nil, "max" => 6, "min" => 3
                }
              }, "disabled" => false
            }
          }
        }
      },
      "id" => "kylVJwwU5",
      "format" => :json,
      "controller" => "api/v1/analyses",
      "action" => "save",
      "analysis" => {
        "id" => "kylVJwwU5"
      }
    }.to_ostruct
  end

  def save
    search_id = data.id
    search = data.search
    item = search.query
    league = League.find_by(name: search.league)

    filters = item.filters
    stats = item.stats
    
    item = Item.find_or_create_by(name: item.name, item_type: item.type)
    analysis = current_user.leagueal_analysis_for_item(item)

    analysis.max_buyout = 2
    analysis.buyout_currency = 'chaos'
    analysis.min_sellout = 2.5
    analysis.sellout_currency = 'exalted'
    analysis.search_params = {
      stats: stats,
      filters: filters
    }
    analysis.search_id = search_id
    analysis.save!

    render json: {
      status: 'success'
    }, status: 200
  end

  def update_league_analysis
    @league_analysis = LeagueAnalysis.find(params[:id])
    @league_analysis.update(league_analysis_params)

    render json: {
      status: 'success'
    }, status: 200
  end

  def league_analysis_params 
    params.permit(:comments)
  end
end