class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def clamp_quality(delta)
    @quality = [[@quality + delta, 0].max, 50].min
  end

  def decrement_quality
    clamp_quality(-1)
  end

  def increment_quality
    clamp_quality(1)
  end

  def reset_quality
    @quality = 0
  end

  def is_brie?
    @name == 'Aged Brie'
  end

  def is_concert?
    @name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def is_hand?
    @name == 'Sulfuras, Hand of Ragnaros'
  end

  def is_mana?
    @name == 'Conjured Mana Cake'    
  end

  def tick_phase_one
    if is_brie? || is_concert?
      increment_quality
      return unless is_concert?

      increment_quality if @days_remaining < 11
      increment_quality if @days_remaining < 6
    elsif @quality < 50
      decrement_quality if is_mana?
      decrement_quality unless is_hand?
    end    
  end

  def tick_phase_two
    return increment_quality if is_brie?
    return reset_quality if is_concert?
    decrement_quality if is_mana?
    decrement_quality unless is_hand?
  end

  def tick
    tick_phase_one

    @days_remaining -= 1 unless is_hand?
    return unless @days_remaining < 0

    tick_phase_two
  end
end
