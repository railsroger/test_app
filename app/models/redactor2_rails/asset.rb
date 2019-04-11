class Redactor2Rails::Asset < ActiveRecord::Base
  include Redactor2Rails::Orm::ActiveRecord::AssetBase
end

# == Schema Information
#
# Table name: redactor2_assets
#
#  assetable_id      :integer
#  assetable_type    :string(30)
#  created_at        :datetime         not null
#  data_content_type :string
#  data_file_name    :string
#  data_file_size    :integer
#  data_updated_at   :datetime
#  height            :integer
#  id                :bigint(8)        not null, primary key
#  type              :string(30)
#  updated_at        :datetime         not null
#  width             :integer
#
# Indexes
#
#  idx_redactor2_assetable       (assetable_type,assetable_id)
#  idx_redactor2_assetable_type  (assetable_type,type,assetable_id)
#
