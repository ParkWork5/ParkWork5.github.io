[fwBasic]
status = enabled
incoming = deny
outgoing = allow
routed = disabled

[Rule0]
ufw_rule = 67/udp ALLOW IN Anywhere
description = DHCP
command = /usr/sbin/ufw allow in proto udp from any to any port 67
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 67/udp
iface = 
routed = 
logging = 

[Rule1]
ufw_rule = 69 ALLOW IN Anywhere
description = TFTP
command = /usr/sbin/ufw allow in from any to any port 69
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 69
iface = 
routed = 
logging = 

[Rule2]
ufw_rule = 111 ALLOW IN Anywhere
description = Time
command = /usr/sbin/ufw allow in from any to any port 111
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 111
iface = 
routed = 
logging = 

[Rule3]
ufw_rule = 68 ALLOW IN Anywhere
description = DHCP
command = /usr/sbin/ufw allow in from any to any port 68
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 68
iface = 
routed = 
logging = 

[Rule4]
ufw_rule = 80 ALLOW IN Anywhere
description = HTTP
command = /usr/sbin/ufw allow in from any to any port 80
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 80
iface = 
routed = 
logging = 

[Rule5]
ufw_rule = 443 ALLOW IN Anywhere
description = HTTPs
command = /usr/sbin/ufw allow in from any to any port 443
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 443
iface = 
routed = 
logging = 

[Rule6]
ufw_rule = 8080 ALLOW IN Anywhere
description = HTTPProxy
command = /usr/sbin/ufw allow in from any to any port 8080
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 8080
iface = 
routed = 
logging = 

[Rule7]
ufw_rule = 8000 ALLOW IN Anywhere
description = HTTPProxy
command = /usr/sbin/ufw allow in from any to any port 8000
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 8000
iface = 
routed = 
logging = 

[Rule8]
ufw_rule = 22 ALLOW IN Anywhere
description = SSH
command = /usr/sbin/ufw allow in from any to any port 22
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 22
iface = 
routed = 
logging = 

[Rule9]
ufw_rule = 138 ALLOW IN Anywhere
description = NetBIOS
command = /usr/sbin/ufw allow in from any to any port 138
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 138
iface = 
routed = 
logging = 

[Rule10]
ufw_rule = 139 ALLOW IN Anywhere
description = NetBIOS
command = /usr/sbin/ufw allow in from any to any port 139
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 139
iface = 
routed = 
logging = 

[Rule11]
ufw_rule = 1024:65535/udp ALLOW IN Anywhere
description = Emp
command = /usr/sbin/ufw allow in proto udp from any to any port 1024:65535
policy = allow
direction = in
protocol = udp
from_ip = 
from_port = 
to_ip = 
to_port = 1024:65535
iface = 
routed = 
logging = 

[Rule12]
ufw_rule = 1024:65535/tcp ALLOW IN Anywhere
description = Emp
command = /usr/sbin/ufw allow in proto tcp from any to any port 1024:65535
policy = allow
direction = in
protocol = tcp
from_ip = 
from_port = 
to_ip = 
to_port = 1024:65535
iface = 
routed = 
logging = 

[Rule13]
ufw_rule = 67/udp (v6) ALLOW IN Anywhere (v6)
description = DHCP
command = /usr/sbin/ufw allow in proto udp from any to any port 67
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 67/udp
iface = 
routed = 
logging = 

[Rule14]
ufw_rule = 69 (v6) ALLOW IN Anywhere (v6)
description = TFTP
command = /usr/sbin/ufw allow in from any to any port 69
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 69
iface = 
routed = 
logging = 

[Rule15]
ufw_rule = 111 (v6) ALLOW IN Anywhere (v6)
description = Time
command = /usr/sbin/ufw allow in from any to any port 111
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 111
iface = 
routed = 
logging = 

[Rule16]
ufw_rule = 68 (v6) ALLOW IN Anywhere (v6)
description = DHCP
command = /usr/sbin/ufw allow in from any to any port 68
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 68
iface = 
routed = 
logging = 

[Rule17]
ufw_rule = 80 (v6) ALLOW IN Anywhere (v6)
description = HTTP
command = /usr/sbin/ufw allow in from any to any port 80
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 80
iface = 
routed = 
logging = 

[Rule18]
ufw_rule = 443 (v6) ALLOW IN Anywhere (v6)
description = HTTPs
command = /usr/sbin/ufw allow in from any to any port 443
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 443
iface = 
routed = 
logging = 

[Rule19]
ufw_rule = 8080 (v6) ALLOW IN Anywhere (v6)
description = HTTPProxy
command = /usr/sbin/ufw allow in from any to any port 8080
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 8080
iface = 
routed = 
logging = 

[Rule20]
ufw_rule = 8000 (v6) ALLOW IN Anywhere (v6)
description = HTTPProxy
command = /usr/sbin/ufw allow in from any to any port 8000
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 8000
iface = 
routed = 
logging = 

[Rule21]
ufw_rule = 22 (v6) ALLOW IN Anywhere (v6)
description = SSH
command = /usr/sbin/ufw allow in from any to any port 22
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 22
iface = 
routed = 
logging = 

[Rule22]
ufw_rule = 138 (v6) ALLOW IN Anywhere (v6)
description = NetBIOS
command = /usr/sbin/ufw allow in from any to any port 138
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 138
iface = 
routed = 
logging = 

[Rule23]
ufw_rule = 139 (v6) ALLOW IN Anywhere (v6)
description = NetBIOS
command = /usr/sbin/ufw allow in from any to any port 139
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 139
iface = 
routed = 
logging = 

[Rule24]
ufw_rule = 1024:65535/udp (v6) ALLOW IN Anywhere (v6)
description = Emp
command = /usr/sbin/ufw allow in proto udp from any to any port 1024:65535
policy = allow
direction = in
protocol = udp
from_ip = 
from_port = 
to_ip = 
to_port = 1024:65535
iface = 
routed = 
logging = 

[Rule25]
ufw_rule = 1024:65535/tcp (v6) ALLOW IN Anywhere (v6)
description = Emp
command = /usr/sbin/ufw allow in proto tcp from any to any port 1024:65535
policy = allow
direction = in
protocol = tcp
from_ip = 
from_port = 
to_ip = 
to_port = 1024:65535
iface = 
routed = 
logging = 

