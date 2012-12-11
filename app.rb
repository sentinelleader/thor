#! /usr/bin/ruby
require 'rubygems'
require 'choice'

Choice.options do
  header ''
  header 'Specific options:'
  
option :action do
      short '-a'
      long '--action=ACTION'
      desc 'Specify the action -- add or delete'
      default 'enable'
    end
option :filter do
	short '-f'
	long '--filter=FILTER'
	desc 'Specify the filter -- header,body,subject etc...'
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
puts 'action: ' + Choice.choices[:action]
