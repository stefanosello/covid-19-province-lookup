class Api::V1::GeoDataController < ApplicationController
  def get
    response = {}
    if params['region'].present? 
      data = Region.includes(:provinces).find(params['region'])
      response = data.as_json
      response['provinces'] = data.provinces.as_json
    else
      data = Nation.includes(regions: :provinces)
      if params['nation'].present?
        data = [data.find(params['nation'])]
      else
        data = data.all
      end
      data.each do |nation|
        response[] << nation.as_json
        response["regions"] = data.regions.map do |region|
          region_data = region.as_json
          region_data["provinces"] = region.provinces.as_json
          region_data
        end
      end
    end

    respond_to do |format|
      format.json { render :json => response }
    end
  end
end