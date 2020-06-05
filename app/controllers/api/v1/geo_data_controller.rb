class Api::V1::GeoDataController < ApplicationController

  def get
    response = []
    nation_code = params["nation"].upcase rescue nil
    region_label = params["region"].capitalize rescue nil
    
    nations = Nation.includes(regions: :provinces)
    if nation_code.present?
      nations = nations.where(code: nation_code)
    end
    if region_label.present?
      nations = nations.where(regions: {label: region_label})
    end
    
    nations.each do |nation|
      nation_converted = nation.as_json
      nation_converted["regions"] = Hash.new
      nation.regions.map do |region|
        region_converted = region.as_json
        region_converted["provinces"] = Hash.new
        region.provinces.each do |province|
          if province.initials.present?
            region_converted["provinces"][province.code] = province
          end
        end
        nation_converted["regions"][region.code] = region_converted
      end.as_h
      response << nation_converted
    end


    respond_to do |format|
      format.json { render :json => response }
    end
  end

  def get_nearest_province
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f

    response = Province.find_closest(latitude, longitude)

    respond_to do |format|
      format.json { render :json => response }
    end
  end
end