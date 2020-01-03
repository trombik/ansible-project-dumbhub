
# frozen_string_literal: true

require_relative "../spec_helper"

service = "squid"
ports = [3128]

describe service(service) do
  it { should be_running }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
