> ## 新版 Teambition API 正在接入中

# Ruby Gem : Teambition
[![Gem Version](https://badge.fury.io/rb/teambition.svg)](http://badge.fury.io/rb/teambition)
[![Build Status](https://travis-ci.org/aidistan/ruby-teambition.svg?branch=master)](https://travis-ci.org/aidistan/ruby-teambition)
[![Maintainability](https://api.codeclimate.com/v1/badges/c1c85d7baea5ec6f3b73/maintainability)](https://codeclimate.com/github/aidistan/ruby-teambition/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c1c85d7baea5ec6f3b73/test_coverage)](https://codeclimate.com/github/aidistan/ruby-teambition/test_coverage)
[![Docs Status](http://inch-ci.org/github/aidistan/ruby-teambition.svg?branch=master)](http://inch-ci.org/github/aidistan/ruby-teambition)

Teambition API 的 Ruby Gem 封装，支持作为 Rails 插件使用。

## 安装方法

通过 Gem

```shell
gem install teambition
```

通过 Gemfile

```ruby
gem 'teambition'
```

## 使用方法

- Gem 实现了 OAuth2 的基本功能，API 调用可通过封装好的 `get`，`post`，`put` 和 `delete` 四个方法实现
- 为便于上手和测试，Rakefile 中定义了 `spec:setup` 任务，用以获取令牌和配置 *spec_helper.rb*
- [项目 Wiki](https://github.com/aidistan/ruby-teambition/wiki) 中有 Gem 在不同场景下的使用案例可供参考

## 许可协议

Copyright (c) 2015-2020 Aidi Stan under [the MIT License](https://github.com/aidistan/ruby-teambition/blob/master/LICENSE)
