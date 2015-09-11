require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# spec
RSpec::Core::RakeTask.new do
  unless File.exist?('spec/spec_helper.rb')
    puts "Please run `rake spec:setup` first to setup 'spec/spec_helper.rb'"
    exit
  end
end

# spec:setup
namespace :spec do
  desc 'Setup the test helper for RSpec'
  task :setup do
    require 'highline/import'
    require 'teambition'
    include Teambition::API

    say "Let's get a redirect url first:"
    say "1. open 'http://request.lesschat.com/create'"
    say '2. copy the url shown in the page'
    Teambition.callback_url = ask '3. paste it here:'

    say '---'

    say "Let's get a client key and a client secret now:"
    say "1. open 'https://account.teambition.com/my/apps'"
    say "2. create a new app and fill 'Callback URL' with the redirect url we got"
    Teambition.client_key = ask "3. paste your client key here:"
    Teambition.client_secret = ask "4. paste your client secret here:"

    say '---'

    say "Let's get a code at last:"
    say "1. Open '#{authorize_url(Teambition.callback_url)}' and sign in with your account"
    say "2. Open '#{Teambition.callback_url}/inspect' and find your code there"
    code = ask '3. paste your code here:'

    file = File.open('spec/spec_helper.rb', 'w')
    file.puts <<-END_OF_DOC
require 'bundler/setup'
require 'teambition'

#
# Set by `rake spec:setup` automatically
#

Teambition.client_key    = '#{Teambition.client_key}'
Teambition.client_secret = '#{Teambition.client_secret}'
Teambition.callback_url  = '#{Teambition.callback_url}'

TEAMBITION_TOKEN = '#{get_access_token(code)}'
    END_OF_DOC
    file.close

    say '---'
    say 'Done. Enjoy testing with RSpec!'
  end
end
