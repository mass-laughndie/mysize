require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  describe "#mysize_id" do
    subject { @user.mysize_id }

    context "when valid mysize_id" do

      it { is_expected.to eq("test1") }
    end
  end
end