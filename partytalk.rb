require 'pry-byebug'

PARTYTALK_TRANSCRIPT = "overheard.log"
TRAINING_TIP = "Just hit enter when you run out of clever things to say for the mic"
CONVERSATION_TIP = "Just hit enter when you leave the room"

class PartyTalk
  attr_reader :partier, :last_response

  def initialize
    @partier = prompt_for("What is your name?")
    @modes = [:training, :conversing]
  end

  def run
    while true do # training
      hint
      next if capture

      break if stop
      toggle_mode
    end
  end

  private

  def capture
    @last_response = prompt_for(prompt)

    if notable_response?
      File.open(PARTYTALK_TRANSCRIPT, 'a+') { |f| f.puts "#{mode}|#{last_response}" }
    else
      return nil
    end
  end

  def stop
    last_response == 'stop'
  end

  def notable_response?
    last_response && last_response.size > 10
  end

  def prompt
    {
      training:   "Hi #{partier}, say something clever for the mic",
      conversing: "Hey, what about those Cowboys?"
    }[mode]
  end

  def tips
    {
      training:   "Just hit enter when you run out of clever things to say for the mic",
      conversing: "Please turn out the lights by typing stop when you leave"
    }
  end

  def tip
    tips[mode]
  end

  def prompt_for(prompt)
    clear 12
    print "#{prompt} >> "
    gets.chomp
  end

  def hint
    clear 12
    puts "hint: " + tip
    clear 10
  end

  def clear(cnt=20)
    cnt.times { puts '' }
  end

  def mode
    @modes.first
  end

  def toggle_mode
    @modes = @modes.rotate
  end
end

if __FILE__ == $0
  20.times { puts '' }
  PartyTalk.new.run
  puts "Turn out the lights!  The party is over!!!!!"
end
