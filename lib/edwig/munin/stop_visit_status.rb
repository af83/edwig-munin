module Edwig::Munin
  class StopVisitStatus < Plugin

    DEPARTURE_STATUS = %w{onTime early delayed cancelled noReport departed}
    ARRIVAL_STATUS = %w{arrived onTime early delayed cancelled noReport missed notExpected}
    UNKNOWN_STATUS = "unknown"

    def values
      stopVisits = RestClient.get("http://#{server}/#{referential}/stop_visits" , {content_type: :json, :Authorization => "Token token=#{token}"})
      stopVisitsTab = JSON.parse(stopVisits)

      counts = {}
      keys.each { |k| counts[k] = 0 }

      stopVisitsTab.each do |stopVisit|
	      departureState = stopVisit["DepartureStatus"]
        departureState = UNKNOWN_STATUS unless DEPARTURE_STATUS.include?(departureState)

	      arrivalState = stopVisit["ArrivalStatus"]
        arrivalState = UNKNOWN_STATUS unless ARRIVAL_STATUS.include?(arrivalState)

	      counts[departure_key(departureState)] += 1
	      counts[arrival_key(arrivalState)] += 1
      end

      counts
    end

    def config
      config = {
        graph_title: "Arrivals and Departures by status",
        graph_order: keys.join(' '),
        graph_info: "Represent StopVisits count by Arrival and Departure statuses",
        graph_args: "--base 1000 -l 0",
        graph_vlabel: "count"
      }

      keys.each_with_index do |key, index|
        label = key.gsub('-',' ')
        config["#{key}.label"] = label
        config["#{key}.draw"] = index == 0 ? 'AREA' : 'STACK'
        config["#{key}.info"] = "The number of StopVisits in #{label}"
      end

      config
    end

    def departure_key(status)
      "DepartureStatus-#{status}"
    end

    def arrival_key(status)
      "ArrivalStatus-#{status}"
    end

    def departure_keys
      DEPARTURE_STATUS.map { |status| departure_key status }
    end

    def arrival_keys
      ARRIVAL_STATUS.map { |status| arrival_key status }
    end

    def keys
      @keys ||= departure_keys + arrival_keys + [departure_key(UNKNOWN_STATUS), arrival_key(UNKNOWN_STATUS)]
    end

  end
end
