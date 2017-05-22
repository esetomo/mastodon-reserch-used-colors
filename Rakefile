
task :clone do
  system 'git clone https://github.com/tootsuite/mastodon.git live'
end

system('git -C live checkout master')

`git -C live log --pretty=format:"%cI_%H" app/javascript/styles`.split("\n").each do |commit|
  task default: "output/#{commit}.txt"
end

rule %r{output/(.+)_(.+).txt} do |t|
  m = %r{output/(.+)_(.+).txt}.match(t.name)
  system("git -C live checkout #{m[2]}")
  system("ruby extract_used_colors.rb > #{t.name}")
end

