# == Class: puppetalive
#
# Demo class to show how puppet works and how handle parameters
# by writing a file to nodes being a parameter the file content.
#
# === Parameters
#
# [*file_content*]
#   This parameter is the text in puppetalive file and it defaults to
#   "parameter -file_content- used for -default text-"
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'puppetalive':
#    file_content => 'puppetalive text content managed by puppet',
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
	file { "/root/puppetalive":
		ensure => "file",
		content=> $file_content,
	}
}
