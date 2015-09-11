# ruby-teambition

Teambition API 的 Ruby 版简易封装, 并支持作为 Rails 插件使用。


## 安装方法

通过 Gem 安装

```shell
gem install teambition
```

通过 Gemfile 方式
```ruby
gem 'teambition'
```


## 使用方法

为便于上手和使用，Gem 只封装了 OAuth2 部分，其他 API 可直接调用 `get`, `post`, `put` 和 `delete` 方法。具体示例如下：

### 直接包含

直接将 `Teambition::API` 包含在当前空间内使用。

```ruby
require 'teambition'
include Teambition::API

# 配置应用
Teambition.client_key    = 'YOUR_CLIENT_KEY'
Teambition.client_secret = 'YOUR_CLIENT_SECRET'

# 配置用户
self.token = 'YOUR_TOKEN'
# 或
@token = 'YOUR_TOKEN'

# 调用 API
me = get '/api/users/me'
puts me['_id']
# => 53f6c****************
```

项目内以下文件可供参考：
- Rakefile
- spec/teambition_spec.rb
- spec/teambition/api_spec.rb
- spec/teambition/api/\*.rb

### 派生扩展

通过宏风格函数 `has_teambition_account` 扩展子类以使用。

```ruby
require 'teambition'

Teambition.client_key    = 'YOUR_CLIENT_KEY'
Teambition.client_secret = 'YOUR_CLIENT_SECRET'

class User
  include Teambition::HasTeambitionAccout
end

class TeambitionUser < User
  attr_accessor :teambition_token
  has_teambition_account namespace: :tb, token: :teambition_token
end

user = TeambitionUser.new
user.teambition_token = 'HIS_TOKEN'
user.tb.get 'api/users/me'
```

项目内以下文件可供参考：
- spec/teambition/has_teambition_account_spec.rb

### In Rails

#### 配置

```ruby
# config/initializers/teambition.rb
require 'teambition/rails/has_teambition_account'

Teambition.client_key    = 'YOUR_CLIENT_KEY'
Teambition.client_secret = 'YOUR_CLIENT_SECRET'
```

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  has_teambition_account token: :teambition_token
end
```

```ruby
# db/migrate/**************_add_teambition_attributes_to_users
class AddTeambitionAttributesToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :teambition_token
      t.string :teambition_id
    end
  end
end
```

#### 使用

```ruby
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only:[:oauth, :oauth_callback]

  def oauth
    if @user.teambition_token && Teambition.valid_access_token?(@user.teambition_token)
      flash[:success] = '已经绑定成功！'
      redirect_to root_path
    else
      redirect_to Teambition.authorize_url
    end
  end

  def oauth_callback
    @user.teambition_token = Teambition.get_access_token(params[:code])
    @user.teambition_id = tb.get('api/users/info')['_id']
    if @user.save
      flash[:success] = '绑定成功！'
    else
      flash[:danger] = '绑定失败！'
    end
    redirect_to root_path
  end

  private

  #...
end
```

> routes.rb 配置略，注意配置好 Teambition 应用的回调地址。


## 参考资料

- [Teambition 开发者中心](https://docs.teambition.com/wiki/)
- [Request 调试工具](http://request.lesschat.com/)


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
