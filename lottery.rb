#!/usr/bin/env ruby

require "/var/www/html/raid-lottery/config/environment"

class Lottery
  def self.run
    participating = []
    # Round up everybody that was out last time
    Raider.all.each do |raider|
      if not raider.participating
        raider.participating = true
        raider.save
        participating << raider
      end
    end    
    # Reset everybody
    Raider.all.each do |raider|
      if not participating.include? raider
        raider.participating = false
        raider.save
      end
    end
    # Pick any auto raiders
    Raider.all.each do |raider|
      if raider.auto
        raider.participating = true
        raider.save
        participating << raider
      end
    end
    # Wrap up the rest
    while participating.length != 6
      random_raider = Raider.all.sample
      if not participating.include? random_raider
        random_raider.participating = true
        random_raider.save
        participating << random_raider
      end
    end
    participating.each do |raider|
      puts raider.name
    end
  end
end

if __FILE__ == $0
  Lottery.run
end
