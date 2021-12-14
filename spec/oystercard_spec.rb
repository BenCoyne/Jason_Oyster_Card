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
        maximum_balance = Oystercard::MAXIMUM_BLANCE
        card.top_up(maximum_balance)
        expect { card.top_up(1) }.to raise_error "The card limit is #{Oystercard::MAXIMUM_BLANCE}"
      end
    end
  end

  describe '#detuct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deduct from balance' do
      card.top_up(Oystercard::MAXIMUM_BLANCE)
      expect { card.deduct(10) }.to change{ card.balance }.by(-10)
    end

  end


end

