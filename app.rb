#! /usr/bin/ruby
require 'rubygems'
require 'choice'
require 'fileutils'
##### Basic Varibles #####
@filename = '/etc/spamassassin/thor.cf' 
@sa_conf  = '/etc/spamassassin/local.cf'

##### Defining CLI Options #####
Choice.options do
  header ''
  header 'Specific options:'
  
option :action do
      short '-a'
      long '--action=ACTION'
      desc 'Specify the action -- add or delete'
      valid %w[add delete]
    end
option :filter do
	short '-f'
	long '--filter=FILTER'
	desc 'Specify the filter -- header,body,subject etc...'
	valid %w[header body subject]
    end
option :keyword do
	short '-k'
	long '--keyword=KEYWORD'
	desc 'Specify the keyword/regexp'
    end
option :score do
	short '-s'
	long '--score=SCORE'
	desc 'Specify the Score'
    end
 option :help do
      long '--help'
      desc 'shows this message'
    end
end

##### Checking the Files #####
if File.exists?(@filename)
	puts "file exists"
else
	puts "file doesn't exist, so creating the file"
	File.new("#{@filename}", File::CREAT|File::TRUNC|File::RDWR, 0644)
end
if File.read(@sa_conf).include?('thor')
	puts "file is included"
else
	tempfile=File.open("/tmp/file.tmp", 'w')
	f=File.new(@sa_conf)
	f.each do |line|
	      	tempfile<<line
		    if line =~/^include/
			     tempfile << "include #{@filename}\n"
		  end
	end
	f.close
	tempfile.close

	FileUtils.mv("/tmp/file.tmp", @sa_conf)
end
##### Starting Attack #####
if Choice.choices[:action] == 'add'
	puts 'add'
   if Choice.choices[:filter] == nil
	   puts 'Please mention the filter'
   end
   if Choice.choices[:keyword] == nil
           puts 'Please mention the keyword/regexp'
   end
   if Choice.choices[:score] == nil
           puts 'Please mention the score'
   end
else
	puts 'delete'
end
