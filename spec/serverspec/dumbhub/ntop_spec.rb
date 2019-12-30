# frozen_string_literal: true

require_relative "../spec_helper"

service = "ntopng"
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
    when "prod"
      its(:content) { should match(/--disable-login=0/) }
    end
  end
end
