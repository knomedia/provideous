require "provideous/version"
require 'fileutils'
require 'erb'
require 'pry'

module Provideous
  attr_accessor :options
  class Builder

    def create_project options
      @options = options
      puts "Creating project #{options[:project]}"
      make_dir
      copy_video
      cd_to_project
      compress_video
      create_poster
      compile_erb_templates
      copy_files
      open_file
    end

    def make_dir
      FileUtils.mkdir @options[:project]
    end

    def copy_video
      vid_file = File.new( @options[:vid_file] )
      if (File.file? vid_file)
        filename = File.basename @options[:vid_file]
        FileUtils.cp @options[:vid_file], "#{@options[:project]}/#{filename}"
      end
    end

    def cd_to_project
      FileUtils.cd @options[:project]
    end

    def compress_video
      if @options[:skip] != true
        puts "Using 'videously' to compress and normalize file"
        file = @options[:vid_file]
        @web = File.basename( file, ".*")
        @web = "web_#{@web}.mp4"
        system "videously #{file} #{@web}"
        clean_up_old_video
      else 
        @web = @options[:vid_file]
      end
    end

    def clean_up_old_video
      FileUtils.rm @options[:vid_file]
    end

    def create_poster
      @poster = File.basename( @web, ".*")
      @poster = "#{@poster}.jpg"
      `ffmpeg -ss 00:00:01.01 -i #{@web} -y -f image2 -vcodec mjpeg -vframes 1 -loglevel panic #{@poster}`
    end

    def compile_erb_templates
      title = @options[:project]
      video = @web
      poster = @poster
      template_file = File.join(File.dirname(File.expand_path(__FILE__)), "templates/index.html.erb")
      template = ""
      File.open( template_file, 'r') {|f| template = ERB.new(f.read()) }
      File.open( "index.html", 'w') {|f| f.write(template.result(binding) )}
    end

    def copy_files
      assets_dir = File.join(File.dirname(File.expand_path(__FILE__)), "assets")
      FileUtils.cp_r "#{assets_dir}/.", "." 
    end

    def open_file
      `open index.html`
    end

    def print_usage
      puts "Usage:"
      puts "===================================="
      puts "** Create a new project **"
      puts "===================================="
      puts ""
      puts "    provideous project_name vid_file"
      puts ""
      puts ""
      
    end
    
  end
  
end
