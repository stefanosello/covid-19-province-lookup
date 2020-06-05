class LandingPageController < ApplicationController
  DEFAULT_NATION_CODE = "ITA"
  DEFAULT_PROVINCE = "013"

  def index
    # geo-data details
    nation_code = (params["nation"] || DEFAULT_NATION_CODE).upcase
    nation = Nation.includes(regions: :provinces).find(nation_code) 
    @nation = nation.as_json
    @nation["regions"] = Hash.new
    nation.regions.map do |region|
      region_converted = region.as_json
      region_converted["provinces"] = Hash.new
      region.provinces.each do |province|
        if province.initials.present?
          region_converted["provinces"][province.code] = province
        end
      end
      @nation["regions"][region.code] = region_converted
    end

    # time-interval details
    @dates = EpidemicData.where(province_code: DEFAULT_PROVINCE).order(:date).group(:date).pluck(:date)
  end
end
