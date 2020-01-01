# frozen_string_literal: true

require_relative "../spec_helper"

service = "rastream"
log_dir = "/var/log/argus/rastream"
user = "argus"
group = "argus"

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

describe file(log_dir) do
  it { should exist }
  it { should be_directory }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  it { should be_mode 755 }
end
