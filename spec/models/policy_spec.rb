require 'rails_helper'

RSpec.describe Policy, :type => :model do
  it "is valid with valid attributes" do
    subject.name = "Name"
    subject.company_id = Company.last.id
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a company id" do
    subject.company_id = nil
    expect(subject).to_not be_valid
  end

  it "has belongs to a company" do
    assc = described_class.reflect_on_association(:company)
    expect(assc.macro).to eq :belongs_to
  end

  it "has many policies" do
    assc = described_class.reflect_on_association(:employees)
    expect(assc.macro).to eq :has_and_belongs_to_many
  end
end
