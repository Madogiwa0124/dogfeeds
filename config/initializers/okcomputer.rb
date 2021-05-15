# Basic認証
basic_auth_config = Rails.configuration.settings.basic_auth
OkComputer.require_authentication(basic_auth_config[:user], basic_auth_config[:password])

# 監視の追加
OkComputer::Registry.register 'redis', OkComputer::RedisCheck.new({})
OkComputer::Registry.register 'ruby version', OkComputer::RubyVersionCheck.new
OkComputer::Registry.register 'cache', OkComputer::GenericCacheCheck.new
OkComputer::Registry.register 'sidekiq latency', OkComputer::SidekiqLatencyCheck.new('default')
# NOTE: 本番は`Heroku Labs: Dyno Metadata`で取得されるCOMMIT HASHを扱う
# https://devcenter.heroku.com/articles/dyno-metadata
env_name = Rails.env.production? ? 'HEROKU_SLUG_COMMIT' : 'SOURCE_VERSION'
OkComputer::Registry.register 'version', OkComputer::AppVersionCheck.new(env: env_name)

# NOTE: zeitwerkの期待するファイルパスとnamespaceを含めたclass名を一致させることが厳しいので、
# okcomputerへのmonkey patchを入れているapp配下はautoloadの対象外にする
Rails.autoloaders.main.ignore("#{Rails.root}/lib/okcomputer/app")
