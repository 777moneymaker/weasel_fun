#!/usr/bin/ruby

# __author__ = 'Milosz Chodkowski PUT'

# Generate possible chars and target sequence.
CHARS = ('A'..'Z').to_a << ' '
TARGET = 'METHINKS IT IS A WEASEL'

# Sample more chars that 'CHARS' array contains.
def sample_with_returns(n, list)
	final = []
	n.times {final << list.sample}
	final
end

# Calculate hamming dist.
def hamming(word)
	raise 'Not equal length' unless word.length == TARGET.length
	count = 0
	word.chars.zip(TARGET.chars).each {|x, y| count += 1 if x != y}
	count
end

# Randomly change one char.
def mutate(word)
	word[rand(0...word.length)] = CHARS.sample
	word
end

# Exec script.
def main
	# Create initial best solution and max score.
	best = sample_with_returns(TARGET.length, CHARS).join
	score = TARGET.length

	until score == 0 do
		# Make 100 copies, mutate each.
		sentences = ([best] * 100).map {|word| mutate(word.dup)}
		# Check which mutation is the best.
		sentences.each do |word|
			if hamming(word) < score
				score = hamming(word)
				best = word
				puts word
				break
			end
		end
	end
end

main()
