require 'rails_helper'

RSpec.describe Company, :type => :model do
  it "is valid with valid attributes" do
    subject.name = "Name"
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "has belongs to a company" do
    assc = described_class.reflect_on_association(:policies)
    expect(assc.macro).to eq :has_many
  end

  it "has many policies" do
    assc = described_class.reflect_on_association(:employees)
    expect(assc.macro).to eq :has_many
  end
end
