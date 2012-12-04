#require dependent libs
require "jumpstart_auth"

class JSTwitter 
	attr_reader :client

	def initialize 
		puts "Initializing..."
		#Experiment with OAuth Here
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		#if message that will check if the tweet message is equal to 140.
		if message.length >= 140
			puts "People are yawning, please shorten your message"
		else
			puts "You've used " + message.length.to_s + " characters out of 140"
		end
		@client.update(message)
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct message:"
		message = tweet("d #{target} #{message}")
		puts message
	end

	def search(q, options={})
		@client.search(q, :count => 50, :result_type => "recent").results.map do |status|
				puts "#{status.from_user}: #{status.text}"
		end
	end

	def run
		puts "Welcome to the Command Line Twitter Client"
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split
			command = parts[0]
			case command 
				when 'q' then puts "Goodbye!"
				when 't' then tweet(parts[1..-1].join(" "))
				when 'dm' then dm(parts[1], parts[2..-1].join(" "))
				when 's' then search(parts[1..-1].join(" "))
				else
					puts "I'm sorry, I don't know how to #{command}"
				end
		end
	end	
end

#execute scripts
jst = JSTwitter.new
#jst.tweet("Hello Testing 12345!")
jst.run

