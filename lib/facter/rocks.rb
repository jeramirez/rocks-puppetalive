# Copyright (C) 2015  Juan Eduardo Ramirez <juaneduardo.ramirez@upr.edu>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class RollInfo
   attr_accessor :roll
   attr_accessor :version
   attr_accessor :arch
   attr_accessor :enabled

   def initialize(roll,version,arch,enabled)
     @roll    = roll.split(':')[0] #strip of semicolon
     @version = version
     @arch    = arch
     @enabled = enabled
   end

   def enabled
     return @roll if @enabled == 'yes'
   end

   def version
     return @version
   end

   def arch
     return @arch
   end
end

class Rocks
   attr_accessor :cmd1
   attr_accessor :cmd2
   attr_accessor :output

   def initialize(cmd1,cmd2)
     @cmd1   = cmd1
     @cmd2   = cmd2
     @output = []
     run_rockscmd
   end

   def run_rockscmd
      @output = Facter::Core::Execution.exec("/opt/rocks/bin/rocks #{@cmd1} #{@cmd2} 2> /dev/null")
   end

   def output
      return @output
   end
  
end

def isrocks
   rockscmd = Rocks.new("list","roll")
   if rockscmd.output.empty?
      return false
   else
      return true
   end
end

Facter.add(:isrocks) do
   confine :kernel => "Linux"
   setcode { isrocks() }
end
   

def find_rolls
   rockscmd = Rocks.new("list","roll")
   allrolls = []
   rockscmd.output.each_line do |line|
     line.strip!
     next if line.empty? or line.match(/ not found/) or line.match(/^NAME /)
     (roll, version, arch, enabled) = line.split(" ")
     allrolls << RollInfo.new(roll,version,arch,enabled)
   end
   
   if allrolls.empty?
      Facter.debug('no rolls available')
   end

   return allrolls
end

if Facter.value(:kernel) == "Linux"
   roll_list=[]
   find_rolls().each do |roll|
      if roll.enabled == roll.roll
         roll_list <<  roll.roll
         Facter.add(":roll_#{roll.roll}") { setcode { roll.roll } }  
         Facter.add(":roll_version_#{roll.roll}") { setcode { roll.version } }  
         Facter.add(":roll_arch_#{roll.roll}") { setcode { roll.arch } }  
      end
   end
   Facter.add(:rolls) { setcode { roll_list.join(",") } }
end
