# frozen_string_literal: true

require_relative "../spec_helper"

service = "snmpd"
ipv4 = "172.16.100.200"

command_snmpwalk_system = "snmpwalk -v 2c -c public -Ox #{ipv4} system"
snmp_sysname = "SNMPv2-MIB::sysName.0 = STRING: dumbhub"

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

describe command(command_snmpwalk_system) do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  its(:stdout) { should match(/#{Regexp.escape(snmp_sysname)}/) }
end

command_snmpwalk_system = "snmpwalk -v 2c -c public -Ox 127.0.0.1 system"
describe command(command_snmpwalk_system) do
  its(:exit_status) { should_not eq 0 }
  its(:stdout) { should match(/#{Regexp.escape("Timeout: No Response from 127.0.0.1")}/) }
end
