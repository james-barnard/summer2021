require 'pry-byebug'

class PartyTalk
  #simulates casual, social conversation
  #prompts for random comments, topics, questions
  #remembers what ppl say
  #regurgitates bits of text

  def initialize
    @modes = %i[ comment topic question ]
    @prompts = {
      comment: "Make a comment, now",
      topic: "Suggest a topic for discussion",
      question: "Time to ask a question"
    }
    @responses = {
      comment: ["initial comment"],
      topic: [],
      question: ["initial question"]
    }
    #load_previous_conversations
  end

  def run
    while true do
      reset_mode

      capture
      break if stop
    end

    puts "goodbye, turn out the lights!"
  end

  private

  attr_reader :mode, :responses

  def say_something
    need_training? ? prompt : self.send("#{mode.to_s}_prompt")
  end

  def need_training?
    @responses[mode].size < 2
  end

  def prompt
    @prompts[mode]
  end

  def topic_prompt
    prompt = "what do you think about #{responses[mode].sample}?"
    mode = :comment
    prompt
  end

  def comment_prompt
    "I heard someone say #{responses[mode].sample}"
  end

  def question_prompt
    prompt = "#{responses[mode].sample}?"
    mode = :comment
    prompt
  end

  def stop
    %w[stop exit quit].any? {|word| word == last_response}
  end

  def reset_mode
    @mode = @modes.sample
  end

  def last_response
    responses[mode].last || ''
  end

  def capture
    responses[mode] << user_input
  end

  def user_input
    ambiance
    print "#{say_something} >> "
    gets.chomp
  end

  def ambiance
    #12.times { puts "you said " + last_response } unless last_response == ''
    puts "the mode is: " + mode.to_s
  end
end

if __FILE__ == $0
  party = PartyTalk.new
  party.run
end
