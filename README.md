# Ruby Gem : teambition
[![Gem Version](https://badge.fury.io/rb/teambition.svg)](http://badge.fury.io/rb/teambition)

Teambition API 的 Ruby Gem 封装, 支持作为 Rails 插件使用。


## 安装方法

通过 Gem 安装

```shell
gem install teambition
```

通过 Gemfile
```ruby
gem 'teambition'
```


## 使用方法

为便于上手和使用，Gem 只封装了 OAuth2 部分，其他 API 可直接调用封装好的 `get`, `post`, `put` 和 `delete` 方法。具体示例如下：

### 直接包含

直接将 `Teambition::API` 包含在当前空间内使用。

```ruby
require 'teambition'
include Teambition::API

# 配置应用
Teambition.client_key    = 'YOUR_CLIENT_KEY'
Teambition.client_secret = 'YOUR_CLIENT_SECRET'
Teambition.callback_url  = 'YOUR_CALLBACK_URL'

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
Teambition.callback_url  = 'YOUR_CALLBACK_URL'

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
Teambition.callback_url  = 'YOUR_CALLBACK_URL'
```

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  has_teambition_account token: :teambition_token
end
```

> 可自定义 namespace 和 token

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

> 定义 teambition_id 字段以方便用户间交互

#### 使用

OAuth2 用法示例

```ruby
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only:[:oauth, :oauth_callback]

  def oauth
    if @user.teambition_token && Teambition.valid_access_token?(@user.teambition_token)
      flash[:success] = '已经绑定！'
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

  #...
end
```

> 注意配置好回调地址


## 参考资料

- [Teambition 开发者中心](https://docs.teambition.com/wiki/)
- [Request 调试工具](http://request.lesschat.com/)


## 许可协议

Copyright (c) 2015 Aidi Stan under [the MIT License](https://github.com/aidistan/ruby-teambition/blob/master/LICENSE)
