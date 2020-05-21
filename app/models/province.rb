class Province < ActiveRecord::Base
  belongs_to :region, class_name: 'Region', foreign_key: 'region_code'
  has_many :epidemic_data, class_name: 'EpidemicData', foreign_key: 'province_code'
end