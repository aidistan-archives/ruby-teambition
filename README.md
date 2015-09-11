# ruby-teambition

Teambition API 的 Ruby 版简易封装, 并支持作为 Rails 插件使用。


## 使用方法

为便于上手和使用，Gem 只封装了 OAuth2 部分，其他 API 可直接调用 `get`, `post`, `put` 和 `delete` 方法。具体示例如下：

### 直接使用

原理与 Rakefile 和 specs 中的 API 调用/测试类似。

```ruby
require 'teambition'
include Teambition::API

# 配置应用
Teambition.client_key    = 'YOUR_CLIENT_KEY'
Teambition.client_secret = 'YOUR_CLIENT_SECRET'

# 配置用户
@teambition_token = 'YOUR_TOKEN'
# 关于如何获取 Token，请参考 Rakefile 中的 spec:setup 方法

# 调用 API
me = get '/api/users/me'
puts me['_id']
# => 53f6c****************
```


## 参考资料

- [Teambition 开发者中心](https://docs.teambition.com/wiki/)


## 许可协议

Copyright (c) 2015 Aidi Stan

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
