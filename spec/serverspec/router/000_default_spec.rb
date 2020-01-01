# frozen_string_literal: true

require_relative "../spec_helper"

describe command "ping -c 1 192.168.20.100" do
  its(:exit_status) { should eq 0 }
end
