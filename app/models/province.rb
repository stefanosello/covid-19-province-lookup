class Province < ActiveRecord::Base
  belongs_to :region, class_name: 'Region', foreign_key: 'region_code'
  has_many :epidemic_data, class_name: 'EpidemicData', foreign_key: 'province_code'

  def self.find_closest(lat, lng)
    sql = "SELECT *, SQRT(POW(69.1 * (latitude - #{lat}), 2) + POW(69.1 * (#{lng} - longitude) * COS(latitude / 57.3), 2)) AS distance
          FROM provinces
          ORDER BY distance
          LIMIT 1;"
    result = self.find_by_sql(ActiveRecord::Base::sanitize_sql(sql)).first

    if result.present?
      result
    else
      nil
    end
  end
end