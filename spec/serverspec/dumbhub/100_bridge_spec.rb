# frozen_string_literal: true

require_relative "../spec_helper"

bridge_interface = "br0"
physical_interfaces = %w[eth2 eth3]
netplan_bridge_file = "/etc/netplan/60-bridge.yaml"

describe file(netplan_bridge_file) do
  its(:content) { should match(/stp:\s+'no'/) }
end

describe command("brctl show #{bridge_interface}") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^#{bridge_interface}\s+\S+.\s+no\s+eth\d+/) }
  its(:stderr) { should eq "" }
end
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
