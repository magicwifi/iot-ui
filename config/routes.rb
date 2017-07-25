Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

get "/:deviceid/:date/show_mains" => "limoes#show_mains", :as => "limoes_show_mains"
get "/:deviceid/:date/show_temperature" => "limoes#show_temperature",  :as => "limoes_show_temperature"
get "/:deviceid/:date/show_temperature_topvalue" => "limoes#show_temperature_topvalue",  :as => "limoes_show_temperature_topvalue"
get "/:deviceid/:date/show_temperature_24h" => "limoes#show_temperature_24h",  :as => "limoes_show_temperature_24h"
get "/:deviceid/:date/show_temperature_boxplot" => "limoes#show_temperature_boxplot",  :as => "limoes_show_temperature_boxplot"
get "/show_index" => "index#index", :as => "show_index"
get "/show_log" => "index#show_log", :as => "show_log"

get "/:deviceid/:date/show_pressure" => "limoes#show_pressure",  :as => "limoes_show_pressure"
get "/:deviceid/:date/show_pressure_topvalue" => "limoes#show_pressure_topvalue",  :as => "limoes_show_pressure_topvalue"
get "/:deviceid/:date/show_pressure_24h" => "limoes#show_pressure_24h",  :as => "limoes_show_pressure_24h"

get "/:deviceid/:date/show_speed" => "limoes#show_speed",  :as => "limoes_show_speed"
get "/:deviceid/:date/show_speed_topvalue" => "limoes#show_speed_topvalue",  :as => "limoes_show_speed_topvalue"
get "/:deviceid/:date/show_speed_24h" => "limoes#show_speed_24h",  :as => "limoes_show_speed_24h"

get "/:deviceid/:date/show_vibration" => "limoes#show_vibration",  :as => "limoes_show_vibration"
get "/:deviceid/:date/show_vibration_topvalue" => "limoes#show_vibration_topvalue",  :as => "limoes_show_vibration_topvalue"
get "/:deviceid/:date/show_vibration_24h" => "limoes#show_vibration_24h",  :as => "limoes_show_vibration_24h"

end
