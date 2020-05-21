class Region < ActiveRecord::Base
  belongs_to :nation, class_name: 'Nation', foreign_key: 'nation_code'
  has_many :provinces, class_name: 'Province', foreign_key: 'region_code'
end