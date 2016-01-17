class OauthController < ActionController::Base

  def create
    oauth_url = 'https://slack.com/api/oauth.access'
    code =  params[:code]
    oauth_url.to_uri.get(
                        "client_id"=>"18658655653.18692787479",
                        "client_secret"=>"90c9ed9def7e2f881ff4f7ba8cfadbd5",
                        "code"=>code,
                        "redirect_uri"=>"https://f418bdce.ngrok.io/bot"
    )
    final_output = {
        yo: 'Mama'
    }
   render json: final_output, status: 200
  end

  private
  def response_params
    params.permit(:code)
  end

end
