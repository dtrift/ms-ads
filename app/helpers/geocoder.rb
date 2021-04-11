module Geocoder
  def coordinates
    lat, lon = geocoder_service.coordinates(params['ad']['city'])
    { lat: lat, lon: lon }
  end

  private

  def geocoder_service
    @geocoder_service ||= Geocoder::Client.new
  end
end
