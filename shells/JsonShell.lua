--------------------------------------------------------------------------
-- Lmod License
--------------------------------------------------------------------------
--
--  Lmod is licensed under the terms of the MIT license reproduced below.
--  This means that Lmod is free software and can be used for both academic
--  and commercial purposes at absolutely no cost.
--
--  ----------------------------------------------------------------------
--
--  Copyright (C) 2008-2018 Robert McLay
--
--  Permission is hereby granted, free of charge, to any person obtaining
--  a copy of this software and associated documentation files (the
--  "Software"), to deal in the Software without restriction, including
--  without limitation the rights to use, copy, modify, merge, publish,
--  distribute, sublicense, and/or sell copies of the Software, and to
--  permit persons to whom the Software is furnished to do so, subject
--  to the following conditions:
--
--  The above copyright notice and this permission notice shall be
--  included in all copies or substantial portions of the Software.
--
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
--  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
--  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
--  NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
--  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
--  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
--  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
--  THE SOFTWARE.
--
--------------------------------------------------------------------------

--------------------------------------------------------------------------
-- Json(): This is a derived class from BaseShell.  It outputs the lua table
--         as a json object

require("strict")

local js        = require("json")

local BaseShell = require("BaseShell")
local Json      = inheritsFrom(BaseShell)
local dbg       = require("Dbg"):dbg()
local Var       = require("Var")
local concatTbl = table.concat
local stdout    = io.stdout
Json.my_name    = "json"
Json.myType     = Json.my_name
Json.js         = ""

function Json.alias(self, k, v)
   -- do nothing: everything is handled in expand
end

function Json.shellFunc(self, k, v)
   -- do nothing: everything is handled in expand
end

function Json.expandVar(self, k, v, vType)
   -- do nothing: everything is handled in expand
end

function Json.unset(self, k, vType)
   -- do nothing: everything is handled in expand
end

function Json.echo(self,...)
   self:_echo(...)
end

function Json.expand(self, tbl)
   self.js = js.encode(tbl)
   BaseShell.expand(self, tbl)
end

function Json.report_failure(self)
   local js_txt = js.encode({_mlstatus=false})
   stdout:write(js_txt)
   dbg.print{   js_txt}
end

function Json.report_success(self)
   local report = js.decode(self.js)
   report["_mlstatus"] = true
   stdout:write(js.encode(report))
   dbg.print{   self.js}
end

return Json
