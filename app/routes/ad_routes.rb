class AdRoutes < Application
  namespace '/v1' do
    get do
      ads = Ad.order(updated_at: :desc).page(params[:page])
      serializer = AdSerializer.new(ads, links: pagination_links(ads))

      render json: serializer.serialized_json
    end

    post do
      result = Ads::CreateService.call(
        ad: ad_params,
        user: current_user
      )

      if result.success?
        serializer = AdSerializer.new(result.ad)
        render json: serializer.serialized_json, status: :created
      else
        error_response(result.ad, :unprocessable_entity)
      end
    end
  end
end
