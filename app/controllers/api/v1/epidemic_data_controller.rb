class Api::V1::EpidemicDataController < ApplicationController
  def get_by_province

    data = Province
      .includes(:epidemic_data)
      .order('epidemic_data.date')
      .find_by_initials(params["province"])

    province = data.as_json
    epidemic_data = data.epidemic_data
    total_cases = epidemic_data.map{|epidemic| epidemic.total_cases}
    delta_cases = []
    total_cases.each_with_index do |number, index|
      previous_index = index - 1
      while !total_cases[previous_index].present? && previous_index >= 0
        previous_index -= 1
      end
      if index != 0
        delta_cases << ((number - total_cases[previous_index]) rescue nil)
      else
        delta_cases << 0
      end
    end

    response = {
      "province" => province,
      "dates" => epidemic_data.map{|epidemic| epidemic.date},
      "total_cases" => total_cases,
      "delta_cases" => delta_cases
    }

    respond_to do |format|
      format.json { render :json => response }
    end
  end
end