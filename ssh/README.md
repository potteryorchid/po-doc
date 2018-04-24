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
