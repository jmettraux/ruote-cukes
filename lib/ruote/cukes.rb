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


#
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

  def self.workitem

    if wi = @vars['workitem']
      return wi
    end

    wi = @vars['storage_participant'].first

    @vars['workitem'] = wi
  end
end

#
# re-opening the cucumber table class to add a fancy to_hash method
#
class Cucumber::Ast::Table

  def to_hash

    self.raw.inject({}) do |h, (k, v)|
      h[k] = (Rufus::Json.decode(v) rescue v)
      h
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

Given /the initial fields are$/ do |table|

  Ruote::Cukes.launch_fields = table.to_hash
end

Given /the initial variables are (.+)$/ do |table|

  Ruote::Cukes.launch_variables = table.to_hash
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

Given /I get the first workitem of (?:participant )?(.+)$/ do |pname|

  sleep 0.100 # give some time to the engine

  Ruote::Cukes.workitem =
    Ruote::Cukes.storage_participant.by_participant(pname).first
end


#
# WORKITEMS

When /^I reply with the workitem$/ do

  Ruote::Cukes.storage_participant.reply(Ruote::Cukes.workitem)
  Ruote::Cukes.workitem = nil
end

When /^I update the workitem with$/ do |table|

  Ruote::Cukes.workitem.fields.merge!(table.to_hash)
end

When /^I reply$/ do

  sleep 0.100 # give some time to the engine

  Ruote::Cukes.storage_participant.reply(
    Ruote::Cukes.storage_participant.all.first)
end

Then /I should have a workitem/ do

  assert_not_nil Ruote::Cukes.workitem
end

Then /^the workitem (?:fields )?should include$/ do |table|

  fields = table.to_hash

  assert_nil fields.find { |k, v|
    Ruote::Cukes.workitem.fields[k] != v
  }
end



#
# PROCESSES

Then /^the process should be alive$/ do

  assert_not_nil Ruote::Cukes.engine.process(Ruote::Cukes.last_wfid)
end

Then /^the process should have no errors$/ do

  assert_equal [], Ruote::Cukes.engine.process(Ruote::Cukes.last_wfid).errors
end

Then /^the process should reach (?:participant )?(.+)$/ do |pname|

  sleep 0.100 # give some time to the engine

  assert_not_nil Ruote::Cukes.storage_participant.all.find { |wi|
    wi.fei.wfid == Ruote::Cukes.last_wfid && wi.participant_name == pname
  }
end

Then /^the process should be over$/ do

  # TODO : check that the process has RUN, the assertion is currently
  #        OK with processes that never ran.

  sleep 0.100 # give some time to the engine

  assert_nil Ruote::Cukes.engine.process(Ruote::Cukes.last_wfid)
end

