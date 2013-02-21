require 'rubygems'
require 'win32/registry' #require it when use ocra(~=ruby2exe)
require 'time'
require 'watir-webdriver'
require 'highline/import'

#$DIR = File.expand_path(File.dirname(__FILE__)) + '/'

def get_id(prompt="Enter ID")
   HighLine.new.ask(prompt) {|q| q.echo = true} #ask() wil been disturb by watir's depdent lib, so use HighLine.new.ask instead of ask()
end

def get_password(prompt="Enter Password")
   HighLine.new.ask(prompt) {|q| q.echo = false}
end

def get_rush_time(prompt="Rush Times?")
   HighLine.new.ask(prompt) {|q| q.echo = true}
end

def hasInput()
	if !ARGV[0] || !ARGV[1] || !ARGV[2] then
		print("input fsis.thu.edu.tw ID PASSWORD\n")
		exit
	end
end

def gen_index(log , file_name="C:\\fsis_index.html")
	File.open("#{file_name}","w+") do |f| f.puts log end
end

ARGV[0] = get_id
ARGV[1] = get_password
ARGV[2] = get_rush_time

hasInput()
puts "initialize..."
gen_index("<a name='jump' href=http://fsis.thu.edu.tw/wwwteac/ccsd3/ccsd3.php?job=&loginn=>link</a>")
index_page = "file:///" + "C:/" + "fsis_index.html"
times = ARGV[2].to_i
puts "ff starting..."
fox = Watir::Browser.start(index_page)

for i in 0 ... times
	fox.goto(index_page)
	l = fox.link :text => 'link'
	l.click
	fox.text_field(:name, 'username').set(ARGV[0])
	fox.text_field(:name, 'passwd').set(ARGV[1])
	fox.input(:value, '登入 / Logon').click
	begin
	if fox.execute_script("window.confirm = function() {return true}") #click JS pop window
		fox.button(:name, 'btnsubmit').click
	else
		puts "---\nlogin success!\n---"
		exit
	end
	rescue
		puts "---\npop clicked! retry...#{times}\n---"
	end
end