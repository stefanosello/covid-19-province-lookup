class EpidemicData < ActiveRecord::Base
  belongs_to :province, class_name: 'Province', foreign_key: 'province_code'
end