require "spec_helper"
require "serverspec"

package = nil
extra_packages = []

case os[:family]
when "openbsd"
  package = "argus-clients"
when "freebsd"
  package = "net-mgmt/argus3-clients"
when "ubuntu"
  package = "argus-client"
when "redhat"
  package = "argus-clients"
end

extra_packages.each do |p|
  describe package p do
    it { should be_installed }
  end
end

describe package(package) do
  it { should be_installed }
end

describe command("ra -h") do
  # XXX ra(1) exits with non-zero even when given `-h` only
  its(:exit_status) { should eq 1 }
  its(:stdout) { should match(/Ra Version \d+\.\d+\.\d+\.\d+/) }
end
