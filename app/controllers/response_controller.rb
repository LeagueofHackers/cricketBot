require 'wrest'
class ResponseController < ActionController::Base
  def create
    key = "imVH7HUAqSmshSlQIW3gmE0cchj3p1PFH3BjsnkfXntHtWKXt3"
    url = 'https://dev132-cricket-live-scores-v1.p.mashape.com'

    match_details = ''
    text = params[:text]
    if false
      # commands = text.split(' ')
      # if commands.first == 'match'
      #   # url = "https://dev132-cricket-live-scores-v1.p.mashape.com/matchdetail.php?matchId=#{commands[1]&seriesId=#{commands[2]}"
        #     # uri = URI.parse(url)
        # request = Net::HTTP::Get.new(uri)
        # request.initialize_http_header({ "X-Mashape-Key" => key, "Accept" => "application/json"})
        #
        # response = Net::HTTP.request(request).body
        #
        # parsed_body = JSON.parse(response)
        # match_details = extract_details(parsed_body)
        else
        body = url.to_uri["/matches.php"].get("","X-Mashape-Key" => key, "Accept" => "application/json").body
        parsed_body = JSON.parse(body)
        matches = parsed_body["matchList"]["matches"]
        match_details  = liveMatches(matches).compact.join("\n")
        end
        body = {
            "text": match_details
        }.to_json

        make_delayed_response(body)
        render json: "OKay Got It", status: 200
        end

        private
        def response_params
          params.permit(:response_url, :text)
        end

        def extract_details(parsed_body)
          p current_batters = parsed_body["matchDetail"]["currentBatters"]

        end

        def liveMatches(matches)
          matches.collect do |match|
            if match["status"] == "LIVE"
              homeTeam = match["homeTeam"]["shortName"]
              awayTeam = match["awayTeam"]["shortName"]
              homeScore = match["scores"]["homeScore"]
              awayScore = match["scores"]["awayScore"]
              matchId = match["id"]
              seriesID = match["series"]["id"]
              "#{homeTeam}( #{homeScore} ) vs #{awayTeam}( #{awayScore} )" #```/cricketBot match #{matchId} #{seriesID}```
            end
          end
        end

        def make_delayed_response(body)
          params[:response_url].to_uri.post(body)
        end
        end

