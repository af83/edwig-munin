module Edwig::Munin
  class PartnerOperationalStatus < Plugin
    def values
      partners = RestClient.get("http://#{server}/#{referential}/partners", {content_type: :json, :Authorization => "Token token=#{token}"})
      partnersTab = JSON.parse(partners)
      counts = Hash.new {|hash, key| hash[key] = 0 }

      partnersTab.each do |partner|
	      operationalState = partner['PartnerStatus']['OperationalStatus'] || partner['PartnerStatus']['OperationnalStatus']
        counts[operationalState] += 1
      end

      counts
    end

    def config
      keys = %w{up down unknown}
      config = {
        graph_title: "Partners by status",
        graph_order: keys.join(' '),
        graph_info: "Represent Partner count by operational statuses",
        graph_args: "--base 1000 -l 0",
        graph_vlabel: "count"
      }

      keys.each_with_index do |key, index|
        label = key.capitalize
        config["#{key}.label"] = label
        config["#{key}.draw"] = index == 0 ? 'AREA' : 'STACK'
        config["#{key}.info"] = "The number of Partner in #{label} status"
      end

      config
    end
  end
end
