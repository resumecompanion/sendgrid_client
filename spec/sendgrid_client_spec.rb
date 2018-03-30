require "spec_helper"

RSpec.describe SendgridClient do
  it "has a version number" do
    expect(SendgridClient::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
