#test in Win7 success ,fox only
require 'rubygems'
require 'win32/registry' #require it when use ocra(~=ruby2exe)
require 'time'
require "watir-webdriver"
require 'highline/import'

def get_id(prompt="Enter ID")
   HighLine.new.ask(prompt) {|q| q.echo = true} #ask() wil been disturb by watir's depdent lib, so use HighLine.new.ask instead of ask()
end

def get_password(prompt="Enter Password")
   HighLine.new.ask(prompt) {|q| q.echo = false} #ask() wil been disturb by watir's depdent lib, so use HighLine.new.ask instead of ask()
end

def get_rush_time(prompt="Rush Times?")
   HighLine.new.ask(prompt) {|q| q.echo = true} #ask() wil been disturb by watir's depdent lib, so use HighLine.new.ask instead of ask()
end

def hasInput()
  if !ARGV[0] || !ARGV[1] || !ARGV[2] then
		print("input fsis.thu.edu.tw ID PASSWORD\n")
		exit
	end
end

ARGV[0] = get_id
ARGV[1] = get_password
ARGV[2] = get_rush_time
hasInput()
times = ARGV[2].to_i

for i in 0 ... times
	fox = Watir::Browser.start("http://fsis.thu.edu.tw/wwwteac/ccsd3/ccsd3.php?job=&loginn=")
	fox.text_field(:name, 'username').set(ARGV[0])
	fox.text_field(:name, 'passwd').set(ARGV[1])
	fox.input(:value, '登入 / Logon').click
	begin
	if fox.execute_script("window.confirm = function() {return true}") #click JS pop window
		fox.button(:name, 'btnsubmit').click
	else
		puts "\nlogin success!\n"
		exit
	end
	rescue
		puts "pop clicked"
	end
end



