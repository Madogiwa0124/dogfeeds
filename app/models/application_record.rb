class ApplicationRecord < ActiveRecord::Base
  self.strict_loading_by_default = true
  self.abstract_class = true
  connects_to database: { writing: :primary, reading: :replica }

  # NOTE: FactoryBot等で生成したインスタンスを利用する等、
  # 再度findし直してeager_loadingするとSQL実行数がかえって増えてしまう恐れがあるので
  # 無効化する口を用意しておく※railsの`ActiveRecord::Core#strict_loading!`の実装を参考
  def strict_loading!(value = true) # rubocop:disable Style/OptionalBooleanParameter
    @strict_loading = value
  end
end
