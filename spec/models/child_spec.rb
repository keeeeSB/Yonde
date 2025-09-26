require 'rails_helper'

RSpec.describe Child, type: :model do
  describe '#age' do
    let(:today) { Date.new(2025, 9, 21) }

    before { allow(Time.zone).to receive(:today).and_return(today) }

    it '誕生日から正しい年齢と月数を返す' do
      alice = Child.new(birthday: Date.new(2022, 1, 1))
      expect(alice.age).to eq '3歳8ヶ月'

      bob = Child.new(birthday: Date.new(2023, 6, 22))
      expect(bob.age).to eq '2歳2ヶ月'

      carol = Child.new(birthday: Date.new(2025, 9, 21))
      expect(carol.age).to eq '0歳0ヶ月'
    end
  end
end
