#!/bin/env ruby
# encoding: utf-8

# You see nothing, enter the nothing.

class Nataniev

  attr_accessor :time
  attr_accessor :path
  attr_accessor :actor

  def initialize

    @time    = Time.new
    @path    = File.expand_path(File.join(File.dirname(__FILE__), "/"))

    load path+"/system/tools.rb"
    load path+"/core/action.rb"
    load path+"/core/corpse.rb"
    load path+"/core/vessel.rb"
    load path+"/core/memory.rb"

    load_folder path+"/system/*"

  end

  def console
    
    @console = @console ? @console : Console.new
    return @console

  end

  def parade

    @parade = @parade ? @parade : Memory_Array.new("paradise")
    return @parade

  end

  def answer q = nil

    parts  = q.split(" ")
    actor  = parts[0]
    action = parts[1] ? parts[1].to_sym : :look
    params = q.sub("#{actor}","").sub("#{action}","").strip
    vessel = actor.to_i > 0 ? make_registered(actor) : make_anonym(actor)

    return vessel.act(action,params)

  end

  def make_registered id

    # TODO
    return make_vessel(instance).new(id.to_i)

  end

  def make_anonym vessel_name

    return make_vessel(vessel_name).new

  end

  def make_vessel vessel_name

    Dir["#{path}/core/vessel/*"].each do |vessel_file_path|
      vessel_file = vessel_file_path.split("/").last
      if vessel_file.like("vessel.#{vessel_name}")
        load("#{path}/core/vessel/vessel.#{vessel_name.downcase}/vessel.rb")
        if Kernel.const_defined?("Vessel#{vessel_name.capitalize}") == true
          return Object.const_get("Vessel"+vessel_name.capitalize)
        end
      end
    end

    # Default to ghost
    require :vessel,:ghost
    return VesselGhost

  end

  #

  def require cat,name

    if File.exist?("#{path}/core/#{cat}/#{cat}.#{name}/#{cat}.rb")
      require_relative "core/#{cat}/#{cat}.#{name}/#{cat}.rb"
    end

    if File.exist?("#{path}/core/#{cat}/#{cat}.#{name}.rb")
      require_relative "core/#{cat}/#{cat}.#{name}.rb"
    end

    if File.exist?("#{path}/core/#{cat}/core.#{name}.rb")
      require_relative "core/#{cat}/core.#{name}.rb"
    end
    
  end

end