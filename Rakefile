require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

namespace :spec do
  desc 'Run unit specs.'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = "spec/unit/*_spec.rb"
  end

  desc 'Run end to end specs.'
  RSpec::Core::RakeTask.new(:e2e) do |t|
    t.pattern = "spec/e2e/*_spec.rb"
  end

  # This task is used to run specs locally: 'rake spec:e2e_setup spec:e2e'
  task :e2e_setup do
    browsermob_proxy_home = `pwd`.to_s.strip + '/tmp/browsermob-proxy-2.1.4'
    ENV['BROWSERMOB_PROXY_HOME'] = browsermob_proxy_home
    browsermob_binary = browsermob_proxy_home + '/bin/browsermob-proxy'
    unless File.exist?(browsermob_binary)
      sh 'sudo apt-get install -y unzip'
      sh "mkdir -p #{browsermob_proxy_home}"
      sh 'cd tmp; curl -k -L -O https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-2.1.4/browsermob-proxy-2.1.4-bin.zip'
      sh 'cd tmp; unzip browsermob-proxy-2.1.4-bin.zip'
      sh "sudo chmod +x #{browsermob_binary}"
    end
  end

end

desc 'Run all specs.'
task :spec => %w[spec:unit spec:e2e]

task :default => :spec
