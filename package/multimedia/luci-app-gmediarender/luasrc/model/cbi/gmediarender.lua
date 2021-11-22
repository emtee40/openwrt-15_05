m = Map("gmediarender", translate("gmediarender server"))

s = m:section(TypedSection, "gmediarender", "")

s:tab("gmrender_set", translate("Basic setting"))
gmrenderbindiplist = s:taboption("gmrender_set", ListValue, "gmrenderbindiplist", translate("Binding ip list"))
gmrenderbindiplist.placeholder = "lan"
gmrenderbindiplist:value("lan", translate("lan"))
gmrenderbindiplist:value("wan", translate("wan"))
gmrenderbindiplist:value("other", translate("other"))
gmrenderbindiplist.default = "lan"
gmrenderbindiplist.rempty = false

gmrenderotherip = s:taboption("gmrender_set", Value, "gmrenderotherip", translate("Other ip"))
gmrenderotherip:depends("gmrenderbindiplist", "other")
gmrenderotherip.rmempty = true
gmrenderotherip.datatype = "ipaddr"
gmrenderotherip.description = translate("Please type ip address")

gmrendersuffix = s:taboption("gmrender_set", Value, "gmrendersuffix", translate("gmediarender friendly-name suffix"))
gmrendersuffix.datatype = "string"
gmrendersuffix.placeholder = "hello"
gmrendersuffix.default = "hello"
gmrendersuffix.rmempty = false


gmrenderextra=s:taboption("gmrender_set", Flag, "gmrenderextra", translate("Wanna download while Listening"))

gmrenderdir = s:taboption("gmrender_set", Value, "gmrenderdir", translate("Download directory"))
gmrenderdir:depends("gmrenderextra", "1")
gmrenderdir.datatype = "string"
gmrenderdir.default = "/tmp"
gmrenderdir.placeholder = "/tmp"
gmrenderdir.rmempty = true
gmrenderdir.description = translate("Please enter a valid directory")

gmrenderlog = s:taboption("gmrender_set", Value, "gmrenderlog", translate("Log file"))
gmrenderlog:depends("gmrenderextra", "1")
gmrenderlog.datatype = "string"
gmrenderlog.default = "gmrender.tmp.log"
gmrenderlog.placeholder = "gmrender.tmp.log"
gmrenderlog.rmempty = true
gmrenderlog.description = translate("Please type log file's name")

s:tab("gmrender_init", translate("Action"))
gmrenderinit = s:taboption("gmrender_init", Button, "gmrenderinit", translate("One-click initialize gmediarender"))
gmrenderinit.rmempty = true
gmrenderinit.inputstyle = "apply"
function gmrenderinit.write(self, section)
	luci.util.exec("/etc/init.d/gmediarender restart >/dev/null 2>&1 &")
end

gmrenderdownload = s:taboption("gmrender_init", Button, "gmrenderdownload", translate("One-click download while Listening"))
gmrenderdownload:depends("gmrenderextra", "1")
gmrenderdownload.rmempty = true
gmrenderdownload.inputstyle = "apply"
function gmrenderdownload.write(self, section)
	luci.util.exec("/usr/share/gmediarender/gmrdownload >/dev/null 2>&1 &")
end

gmrenderdownloadstop = s:taboption("gmrender_init", Button, "gmrenderdownloadstop", translate("One-click STOP download"))
gmrenderdownloadstop:depends("gmrenderextra", "1")
gmrenderdownloadstop.rmempty = true
gmrenderdownloadstop.inputstyle = "apply"
function gmrenderdownloadstop.write(self, section)
	luci.util.exec("/usr/share/gmediarender/gmrdownloadstop > /dev/null 2>&1")
end


return m
