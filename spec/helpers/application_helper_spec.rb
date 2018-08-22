require "rails_helper"

describe Owner do
  describe "helper" do
  let(:owner) { Owner.new(name: Daniel, card_number: 102010202, phone: 2111111, email: dlopezsd@mai.com)}
    it "returns correct percentage of ownerability" do
    let(:owner) { Owner.new(share: 1) }
      expect(owner.convert_share_to_percentage.to_s).to eq("100%")
    end
  end
end
