require 'rails_helper'

describe Message do
  describe '#create' do
    it "is valid with a body, image" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without a message" do
      message = build(:message, body: nil)
      message.valid?
      expect(message.errors[:body]).to include("を入力してください。")
    end

    it "is invalid with a message that has more than 256 characters" do
      message = build(:message, body: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa256")
      message.valid?
      expect(message.errors[:body]).to include ("は255文字以内で入力してください。")
    end

    it "is valid with a message that has less than 255 characters" do
      message = build(:message, body: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa255")
      expect(message).to be_valid
    end
  end
end
