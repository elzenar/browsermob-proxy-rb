require 'spec_helper'
require 'browsermob/proxy/server'

describe 'BrowserMob::Proxy::Server' do
  it "should use the next port number of 'port' parameter for --proxyPortRange value by default" do

    if system 'update-alternatives --version > /dev/null'
      correct_java_binary = `update-alternatives --list java|egrep 'java-8|java-7'|sort -nr|head -1`.to_s.strip
      raise Startaf::Error.new "BrowserMob proxy requires Java 7 or Java 8 for correct work. But the following Java is installed:\n" + `update-alternatives --list java` if correct_java_binary.to_s.empty?
      ENV['JAVACMD'] = correct_java_binary
    end

    port = Selenium::WebDriver::PortProber.above(3000)
    server = BrowserMob::Proxy::Server.new(
        File.join(home, "bin", "browsermob-proxy"),
        :port => port,
        :log => true
    ).start

    proxy = server.create_proxy
    expect(proxy.port).to eq port + 1
  end

  it "should use the next port number of 'port' parameter for --proxyPortRange value by default" do

    if system 'update-alternatives --version > /dev/null'
      correct_java_binary = `update-alternatives --list java|egrep 'java-8|java-7'|sort -nr|head -1`.to_s.strip
      raise Startaf::Error.new "BrowserMob proxy requires Java 7 or Java 8 for correct work. But the following Java is installed:\n" + `update-alternatives --list java` if correct_java_binary.to_s.empty?
      ENV['JAVACMD'] = correct_java_binary
    end

    port = Selenium::WebDriver::PortProber.above(3000)
    server = BrowserMob::Proxy::Server.new(
        File.join(home, "bin", "browsermob-proxy"),
        :port => port,
        :port_range => '10000-10100',
        :log => true
    ).start

    proxy = server.create_proxy
    expect(proxy.port).to eq 10000
  end

end