require 'date'
require 'gruff'

task :clone do
  system 'git clone https://github.com/tootsuite/mastodon.git live'
end

system('git -C live checkout master')

`git -C live log --pretty=format:"%cI_%H" app/javascript/styles`.split("\n").each do |commit|
  task extract: "output/#{commit}.txt"
end

system('git -C live checkout HEAD^')

`git -C live log --pretty=format:"%cI_%H" app/assets/stylesheets`.split("\n").each do |commit|
  task extract: "output/#{commit}.txt"
end

rule %r{output/(.+)_(.+).txt} do |t|
  m = %r{output/(.+)_(.+).txt}.match(t.name)
  system("git -C live checkout #{m[2]}")
  system("ruby extract_used_colors.rb > #{t.name}")
end

file 'output/graph.png' do |t|
  d = []
  c = []
  
  `wc -l output/*.txt`.split(/\n/).each do |line|
    m = %r{(\d+) output/(.+)_.+.txt}.match(line)
    next unless m
    d << m[2]
    c << m[1].to_i
  end

  g = Gruff::Line.new(800)
  g.data(:colors, c)
  g.write(t.name)
end

task :diff do |t|
  prev = 0
  
  `wc -l output/*.txt`.split(/\n/).each do |line|
    m = %r{(\d+) output/(.+)_.+.txt}.match(line)
    next unless m 
    c = m[1].to_i
    print "#{c - prev}\t#{line}\n"
    prev = c
  end  
end
