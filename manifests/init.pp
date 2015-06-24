# == Class: puppetalive
#
# Demo class to show how puppet works and how handle parameters
# by writing a file to nodes being a parameter 'file_content'.
#
# === Parameters
#
# [*file_content*]
#   This parameter is the head text in puppetalive file and it defaults to
#   "parameter -file_content- used for -default text-"
#
# === Variables
#
# isrocks,rolls,roll_$ROLL,roll_version_$ROLL,roll_arch_$ROLL.
#
# [*isrocks*]
#   This variable will trigger a text message in puppetalive file indicating not rolls installed.
#   it is created by the facter file in lib/facter/rocks.rb 
# [*rolls*]
#   This variable will list the rolls installed and active in the rocks cluster. 
#   It is used to write this list in puppetalive file.
# [*roll_$ROLL*]
#   Sample variable created in lib/facter/rocks.rb
# [*roll_version$ROLL*]
#   Sample variable created in lib/facter/rocks.rb
# [*roll_$ROLL*]
#   Sample variable created in lib/facter/rocks.rb
#
# === Examples
#
#  class { 'puppetalive':
#    file_content => 'puppetalive head text content managed by puppet',
#  }
#
# === Authors
#
# J. Eduardo Ramirez <juaneduardo.ramirez@upr.edu>
#
# === Copyright
#
# Copyright 2015 J. E. Ramirez, unless otherwise noted.
#
class puppetalive (
	$file_content = $puppetalive::params::file_content,
){
	if $isrocks {
		$myrolls = " ${rolls}"
	}else{
		$myrolls = " No rolls installed"
	}
	$mytext = "file_content:${file_content}\n\nRolls installed:\n ${myrolls}"
	file { "/root/puppetalive":
		ensure => "file",
		content=> $mytext,
	}
}
