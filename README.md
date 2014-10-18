# Chef::Handler::JenkinsNotifier

The chef-handler-jenkins_notifier gem is a Chef report mechanism that sends
failures to a Jenkins Job.

## Installation

Add this line to your application's Gemfile:

    gem 'chef-handler-jenkins_notifier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chef-handler-jenkins_notifier

## Usage

### Create Jenkins Job

Create a Jenkins job.

### Create recipe

Create a new recipe, with the following contents, and add it to the runlist of your base role in Chef:

```ruby
chef_gem "chef-handler-jenkins_notifier" do
  action :upgrade
end

require 'chef/handler/jenkins_notifier'

chef_handler 'Chef::Handler::Jenkins_Notifier' do
  source 'chef/handler/jenkins_notifier'
  arguments [
    :host => "#{JENKINS_HOST}",
    :port =>  "#{JENKINS_PORT}",
    :path => "/job/#{JOB_NAME}/postBuildResult"
  ]
  action :nothing
end.run_action(:enable)
```

Recipe is written as follows: If you use authentication in Jenkins.

```ruby
chef_gem "chef-handler-jenkins_notifier" do
  action :upgrade
end

require 'chef/handler/jenkins_notifier'

chef_handler 'Chef::Handler::Jenkins_Notifier' do
  source 'chef/handler/jenkins_notifier'
  arguments [
    :host => "#{JENKINS_HOST}",
    :port =>  "#{JENKINS_PORT}",
    :path => "/job/#{JOB_NAME}/postBuildResult",
    :user => "#{user}",
    :pass => "#{pass}"
  ]
  action :nothing
end.run_action(:enable)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/chef-handler-jenkins_notifier/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
