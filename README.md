# ruby-teambition

Teambition API 的 Ruby 版简易封装, 并支持作为 Rails 插件使用。


## 使用方法

为便于学习和使用，Gem 只封装了 OAuth2 部分，其他 API 可直接调用 `get`, `post`, `put` 和 `delete` 方法。具体示例如下：

### 直接使用

原理与 Rakefile 和 specs 中的 API 调用/测试类似。

```ruby
require 'teambition'
include Teambition::API

# 配置应用
Teambition.client_key    = 'YOUR_CLIENT_KEY'
Teambition.client_secret = 'YOUR_CLIENT_SECRET'

# 配置用户
#   关于如何获取 Token 请参考 Rakefile 中的 spec:setup 方法
@teambition_token = 'YOUR_TOKEN'

# 调用 API
me = get '/api/users/me'
puts me['_id']
# => 53f6c****************
```


## 参考资料

- [Teambition 开发者中心](https://docs.teambition.com/wiki/)
