# frozen_string_literal: true

require_relative "../spec_helper"

process = "dumpcap"
extra_packages = case os[:family]
                when "ubuntu"
                  %w[tshark]
                else
                  []
                end

describe process(process) do
  it { should be_running }
end

extra_packages.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end
