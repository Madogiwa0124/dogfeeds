# Basic認証
OkComputer.require_authentication(ENV['BASIC_AUTH_USER'], ENV['BASIC_AUTH_PASSWORD'])
# 監視の追加
OkComputer::Registry.register 'redis', OkComputer::RedisCheck.new({})
OkComputer::Registry.register 'cache', OkComputer::GenericCacheCheck.new
OkComputer::Registry.register 'version', OkComputer::AppVersionCheck.new(env: 'SOURCE_VERSION')
