## 保存SSH远程访问 ##

# Step one
vi ~/.ssh/config

# Step two: Add configration below into ~/.ssh.config file.
Host service1
    HostName host_ip
    Port 22
    User user_name

# Step three: Access service with name.
ssh service1

# For excemple
Host 180
        HostName 10.199.1.180
        Port 22
        User security

Host 179
        HostName 10.199.1.179
        Port 22
        User security
