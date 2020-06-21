#!/usr/bin/expect -f
spawn ssh admin@fw-ip -p ssh-port
expect "password"
send "fw-password\r"
expect "#"
send -- "config vdom\r"
send -- "edit IC-CLOUD\r"
send -- "diagnose user quarantine list all\r"
#expect {
#            "Control-c" { send -- " "; exp_continue}
#            "#" {send -- "exit\r"}
#    }

expect {
    "#" {
        send "exit\r"
        exp_continue
    }
}
#interact
