# frozen_string_literal: true

require_relative "../spec_helper"

service = "ntopng"
interface_bridge = "br0"
ports = [3000]
config = case os[:family]
         when "freebsd"
           "/usr/local/etc/ntopng/ntopng.conf"
         else
           "/etc/ntopng/ntopng.conf"
         end

context "after provision finishes" do
  describe service(service) do
    it { should be_running }
  end

  ports.each do |port|
    describe port(port) do
      it { should be_listening }
    end
  end

  describe file(config) do
    it { should be_file }
    case ENV["ANSIBLE_ENVIRONMENT"]
    when "virtualbox"
      its(:content) { should match(/--disable-login=1/) }
      its(:content) { should match(/--disable-autologout/) }
    when "prod"
      its(:content) { should match(/--disable-login=0/) }
      its(:content) { should_not match(/--disable-autologout/) }
    end
    its(:content) { should match(/--interface=#{interface_bridge}/) }
    its(:content) { should match(/--community/) }
  end
end
