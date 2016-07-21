# Ruby Gem : Teambition
[![Gem Version](https://badge.fury.io/rb/teambition.svg)](http://badge.fury.io/rb/teambition)
[![Build Status](https://travis-ci.org/aidistan/ruby-teambition.svg?branch=master)](https://travis-ci.org/aidistan/ruby-teambition)
[![Docs Status](http://inch-ci.org/github/aidistan/ruby-teambition.svg?branch=master)](http://inch-ci.org/github/aidistan/ruby-teambition)

Teambition API 的 Ruby Gem 封装, 支持作为 Rails 插件使用。

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

为便于上手和测试，Rakefile 中定义了 `spec:setup` 任务，用以获取令牌和配置 *spec_helper.rb*。

Gem 实现了 OAuth2 的基本功能，API 的调用可通过封装好的 `get`，`post`，`put` 和 `delete` 方法实现。具体用例可参考 [项目 Wiki](https://github.com/aidistan/ruby-teambition/wiki) 。

## 参考资料

- [Teambition 开发者中心](https://docs.teambition.com/wiki/)
- [RequestBin 调试工具](http://requestb.in/)

## 许可协议

Copyright (c) 2015-2016 Aidi Stan under [the MIT License](https://github.com/aidistan/ruby-teambition/blob/master/LICENSE)
