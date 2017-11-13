module Edwig::Munin
  class ModelCount < Plugin
    def values
      values = {}

      #stop_visits.value
      stopVisits = RestClient.get("http://#{server}/#{referential}/stop_visits" , {content_type: :json, :Authorization => "Token token=#{token}"})
      stopVisitsTab = JSON.parse(stopVisits)
      values[:stop_visits] = stopVisitsTab.count

      #vehicle_journeys.value
      vehicleJourneys = RestClient.get("http://#{server}/#{referential}/vehicle_journeys" , {content_type: :json, :Authorization => "Token token=#{token}"})
      vehicleJourneysTab = JSON.parse(vehicleJourneys)
      values[:vehicle_journeys] = vehicleJourneysTab.count

      #stop_areas.value
      stopAreas = RestClient.get("http://#{server}/#{referential}/stop_areas" , {content_type: :json, :Authorization => "Token token=#{token}"})
      stopAreasTab = JSON.parse(stopAreas)
      values[:stop_areas] = stopAreasTab.count

      #lines.value
      lines = RestClient.get("http://#{server}/#{referential}/lines" , {content_type: :json, :Authorization => "Token token=#{token}"})
      linesTab = JSON.parse(lines)
      values[:lines] = linesTab.count

      values
    end

    def config
      keys = %w{lines stop_areas vehicle_journeys stop_visits}
      config = {
        host_name: server,
        graph_title: "Models count",
        graph_order: keys.join(' '),
        graph_info: "Represent all models count",
        graph_args: "--base 1000 -l 0",
        graph_vlabel: "count"
      }

      keys.each_with_index do |key, index|
        label = key.split('_').map(&:capitalize).join
        config["#{key}.label"] = label
        config["#{key}.info"] = "The number of #{label}"
      end

      config
    end
  end
end
