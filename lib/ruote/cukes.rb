#--
# Copyright (c) 2010, John Mettraux, jmettraux@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Made in Japan.
#++


require 'test/unit/assertions'
include Test::Unit::Assertions
  # not sure about that for now...

require 'json'
require 'ruote'

require 'ruote/cukes/version'


# a variable container in a singleton, or something like that
#
module Ruote::Cukes

  def self.method_missing (m, *args)
    m = m.to_s
    if args.size == 1 && mm = m.match(/^(.+)=$/)
      (@vars ||= {})[mm[1]] = args.first
    elsif args.size == 0
      (@vars ||= {})[m]
    else
      super
    end
  end
end


#
# ENGINE

Given /I have a ruote engine/ do

  Ruote::Cukes.engine =
    Ruote::Engine.new(Ruote::Worker.new(Ruote::HashStorage.new()))
end


#
# LAUNCH

Given /the initial fields are (.+)$/ do |fields|

  fields = "{#{fields}}" unless fields.match(/^{.+}$/)

  Ruote::Cukes.launch_fields = Rufus::Json.decode(fields)
end

Given /the initial variables are (.+)$/ do |vars|

  vars = "{#{vars}}" unless vars.match(/^{.+}$/)

  Ruote::Cukes.launch_variables = Rufus::Json.decode(vars)
end

Given /I launch the flow at (.+)$/ do |path|

  Ruote::Cukes.last_wfid = Ruote::Cukes.engine.launch(
    path,
    Ruote::Cukes.launch_fields || {},
    Ruote::Cukes.launch_variables || {})
end

Given /I launch the flow$/ do |process_definition|

  Ruote::Cukes.last_wfid = Ruote::Cukes.engine.launch(
    process_definition,
    Ruote::Cukes.launch_fields || {},
    Ruote::Cukes.launch_variables || {})
end


#
# PARTICIPANTS

Given /the catch[- ]?all participant is registered/ do

  Ruote::Cukes.storage_participant =
    Ruote::Cukes.engine.register_participant('.+', Ruote::StorageParticipant)

  Ruote::Cukes.storage_participant.context = Ruote::Cukes.engine.context
    # due to a bug in ruote 2.1.7, remove when 2.1.8 is out
end

Given /I get the first workitem of participant (.+)$/ do |pname|

  Ruote::Cukes.workitem =
    Ruote::Cukes.storage_participant.by_participant(pname).first
end


#
# WORKITEMS

Then /I should have a workitem/ do

  assert_not_nil Ruote::Cukes.workitem
end


#
# PROCESSES

Then /^the process should be alive$/ do

  assert_not_nil Ruote::Cukes.engine.process(Ruote::Cukes.last_wfid)
end

Then /^the process should have no errors$/ do

  assert_equal [], Ruote::Cukes.engine.process(Ruote::Cukes.last_wfid).errors
end

Then /^the process should reach (participant )?(.+)$/ do |_, pname|

  assert_not_nil Ruote::Cukes.storage_participant.all.find { |wi|
    wi.fei.wfid == Ruote::Cukes.last_wfid && wi.participant_name == pname
  }
end

