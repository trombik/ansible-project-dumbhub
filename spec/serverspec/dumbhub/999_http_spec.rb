# frozen_string_literal: true

require_relative "../spec_helper"
require "net/http"

host = ENV["TARGET_HOST"]
ansible_host = inventory.host(host)["ansible_host"]
port = 3000

uri = "http://#{ansible_host}:#{port}"
describe uri do
  let(:http_get_response) do
    Net::HTTP.get_response(URI(uri))
  end

  it "should return success" do
    expect(http_get_response).to be_kind_of(Net::HTTPSuccess)
    http_get_response.body
  end

  it "should include 'Welcome to ntopng'" do
    expect(http_get_response.body).to match(/Welcome to ntopng/)
  end

  it "should show ntopng Community Edition is running" do
    expect(http_get_response.body).to match(/ntopng Community Edition/)
  end
end
