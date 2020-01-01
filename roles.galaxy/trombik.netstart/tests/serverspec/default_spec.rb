require "spec_helper"
require "serverspec"

describe file("/etc/hostname.vether0") do
  it { should exist }
  it { should be_mode 640 }
  it { should be_owned_by "root" }
  it { should be_grouped_into "wheel" }
  its(:content) { should match(/Managed by ansible/) }
  its(:content) { should match(/up/) }
end

describe file("/etc/hostname.bridge0") do
  it { should exist }
  it { should be_mode 640 }
  it { should be_owned_by "root" }
  it { should be_grouped_into "wheel" }
  its(:content) { should match(/Managed by ansible/) }
  its(:content) { should match(/add em0/) }
  its(:content) { should match(/add vether0/) }
  its(:content) { should match(/up/) }
end

describe command("ifconfig vether0") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/vether0:.*UP.*RUNNING/) }
  its(:stderr) { should eq "" }
end

describe command("ifconfig bridge0") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/bridge0:.*UP,RUNNING/) }
  its(:stdout) { should match(/vether0.*LEARNING,DISCOVER/) }
  its(:stdout) { should match(/em0.*LEARNING,DISCOVER/) }
  its(:stderr) { should eq "" }
end
