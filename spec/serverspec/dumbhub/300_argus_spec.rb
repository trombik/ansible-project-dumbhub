# frozen_string_literal: true

require_relative "../spec_helper"

service = "argus"
ports = [561]

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |port|
  describe port(port) do
    it { should be_listening }
  end
end
