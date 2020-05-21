class Nation < ActiveRecord::Base
  has_many :regions, class_name: 'Region', foreign_key: 'nation_code'
end