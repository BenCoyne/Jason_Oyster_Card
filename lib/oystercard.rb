

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :travelling

  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(amount)
    @amount = amount
    
    raise "The card limit is #{MAXIMUM_BALANCE}" if limit_exceeded?
    
    @balance += @amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Insufficient funds for touch in" if @balance < MINIMUM_BALANCE
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

  def in_journey?
    @travelling
  end

  private

  def limit_exceeded?
    @balance + @amount > MAXIMUM_BALANCE
  end
end

