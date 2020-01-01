# frozen_string_literal: true

require_relative "../spec_helper"

bridge_interface = "br0"
physical_interfaces = ["eth2", "eth3"]


physical_interfaces.each do |i|
  describe interface(i) do
    it { should exist }
    it { should be_up }
  end
end
describe interface(bridge_interface) do
  it { should exist }
  it { should be_up }
end
