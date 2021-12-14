require 'oystercard'

describe Oystercard do
  it { is_expected.to be_an Oystercard }

  subject(:card) { Oystercard.new }

  describe '#balance' do
    it { is_expected.to respond_to(:balance) }

    it 'has an initial balance of zero' do
      expect(card.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    
    it 'can top up balance' do
      expect { card.top_up 10 }.to change{ card.balance }.by 10
    end

    describe 'balance limit' do
      it 'raises an error' do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        card.top_up(maximum_balance)
        expect { card.top_up(1) }.to raise_error "The card limit is #{Oystercard::MAXIMUM_BALANCE}"
      end
    end
  end

  describe '#detuct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deduct from balance' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { card.deduct(10) }.to change{ card.balance }.by(-10)
    end

  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it "is travelling" do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in
      expect(card).to be_in_journey
    end

    it "raises an error when balance is below 1" do
      expect { card.touch_in }.to raise_error "Insufficient funds for touch in"
    end

  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it "is not travelling" do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      card.touch_in 
      card.touch_out
      expect(card).to_not be_in_journey
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it "checks whether card is travelling" do
      expect(card.in_journey?).to eq(card.travelling)
    end


  end
end

