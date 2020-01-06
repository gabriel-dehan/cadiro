module ApplicationHelper
  def fetchJson(file) 
    JSON.parse(render(partial: file))
  end
end
