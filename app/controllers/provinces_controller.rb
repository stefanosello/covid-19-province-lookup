class ProvincesController < ApplicationController
  def show
    province = Province.includes(:epidemic_data).find_by_initials(params["province"])
    @data = {
      "province" => province.as_json,
      "epidemic_data" => province.epidemic_data.as_json
    }.to_json
  end
end