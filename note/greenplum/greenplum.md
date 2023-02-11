# GreenPlum

[TOC]

## Creating the Greenplum Administrative User

- Create the gpadmin group and user.
  
  ```shell
  # 创建用户
  $ groupadd gpadmin
  $ useradd gpadmin -r -m -g gpadmin
  $ passwd gpadmin
  New password: <changeme>
  Retype new password: <changeme>
  ```

- Switch to the gpadmin user and generate an SSH key pair for the gpadmin user.
  
  ```shell
  $ su gpadmin
  $ ssh-keygen -t rsa -b 4096
  Generating public/private rsa key pair.
  Enter file in which to save the key (/home/gpadmin/.ssh/id_rsa):
  Created directory '/home/gpadmin/.ssh'.
  Enter passphrase (empty for no passphrase):
  Enter same passphrase again:
  ```

- Grant sudo access to the gpadmin user.
  
  ```shell
  # run visudo and uncomment the %wheel group entry.
  $ visudo
  
  # Make sure you uncomment the line that has the NOPASSWD keyword.
  %wheel        ALL=(ALL)       NOPASSWD: ALL
  
  # Add the gpadmin user to the wheel group with this command.
  $ usermod -aG wheel gpadmin
  ```

## Validating Your Systems

- Validating Network Performance
  To test network performance, run gpcheckperf with one of the network test run options: parallel pair test (-r N), serial pair test (-r n), or full matrix test (-r M). The utility runs a network benchmark program that transfers a 5 second stream of data from the current host to each remote host included in the test. By default, the data is transferred in parallel to each remote host and the minimum, maximum, average and median network transfer rates are reported in megabytes (MB) per second. If the summary transfer rate is slower than expected (less than 100 MB/s), you can run the network test serially using the -r n option to obtain per-host results. To run a full-matrix bandwidth test, you can specify -r M which will cause every host to send and receive data from every other host specified. This test is best used to validate if the switch fabric can tolerate a full-matrix workload.
  Most systems in a Greenplum Database array are configured with multiple network interface cards (NICs), each NIC on its own subnet. When testing network performance, it is important to test each subnet individually. For example, considering the following network configuration of two NICs per host:
  
  <div>
  <table>
    <thead> 
      <tr>
      <th>Greenplum Host</th>
      <th>Subnet1 NICs</th>
      <th>Subnet2 NICs</th>
      </tr> 
    </thead> 
    <tbody> 
      <tr>
      <td>Segment 1</td>
      <td>sdw1-1</td>
      <td>sdw1-2</td>
      </tr> 
      <tr>
      <td>Segment 2</td>
      <td>sdw2-1</td>
      <td>sdw2-2</td>
      </tr> 
      <tr>
      <td>Segment 3</td>
      <td>sdw3-1</td>
      <td>sdw3-2</td>
      </tr> 
    </tbody>
  </table>
  </div>

- You would create four distinct host files for use with the gpcheckperf network test:
  
  <div>
  <table>
    <thead> 
      <tr>
      <th>hostfile_gpchecknet_ic1</th>
      <th>hostfile_gpchecknet_ic2</th>
      </tr> 
    </thead> 
    <tbody> 
      <tr>
      <td>sdw1-1</td>
      <td>sdw1-2</td>
      </tr> 
      <tr>
      <td>sdw2-1</td>
      <td>sdw2-2</td>
      </tr> 
      <tr>
      <td>sdw3-1</td>
      <td>sdw3-2</td>
      </tr> 
    </tbody>
  </table>
  </div>
  
  You would then run gpcheckperf once per subnet. For example (if testing an even number of hosts, run in parallel pairs test mode):
  
  ```shell
  $ gpcheckperf -f hostfile_gpchecknet_ic1 -r N -d /tmp > subnet1.out
  $ gpcheckperf -f hostfile_gpchecknet_ic2 -r N -d /tmp > subnet2.out
  ```
  
  If you have an odd number of hosts to test, you can run in serial test mode (-r n).

## Validating Disk I/O and Memory Bandwidth

To test disk and memory bandwidth performance, run gpcheckperf with the disk and stream test run options (-r ds). The disk test uses the dd command (a standard UNIX utility) to test the sequential throughput performance of a logical disk or file system. The memory test uses the STREAM benchmark program to measure sustainable memory bandwidth. Results are reported in MB per second (MB/s). To run the disk and stream tests

- Log in on the master host as the gpadmin user.

- Source the greenplum_path.sh path file from your Greenplum installation. For example:
  
  ```shell
  $ source /usr/local/greenplum-db/greenplum_path.sh
  ```

- Create a host file named hostfile_gpcheckperf that has one host name per segment host. Do not include the master host. For example:
  
  ```shell
  sdw1
  sdw2
  sdw3
  sdw4
  ```

- Run the gpcheckperf utility using the hostfile_gpcheckperf file you just created. Use the -d option to specify the file systems you want to test on each host (you must have write access to these directories). You will want to test all primary and mirror segment data directory locations. For example:
  
  ```shell
  $ gpcheckperf -f hostfile_gpcheckperf -r ds -D \
    -d /data1/primary -d  /data2/primary \
    -d /data1/mirror -d  /data2/mirror
  ```

- The utility may take a while to perform the tests as it is copying very large files between the hosts. When it is finished you will see the summary results for the Disk Write, Disk Read, and Stream tests.

## Initializing a Greenplum Database System

```shell
$ gpinitsystem -c /home/gpadmin/gpconfigs/gpinitsystem_config -n zh_CN.utf8 -m 100 -s host2.centos -S /data/gpdb/master --mirror-mode=spread -O /home/gpadmin/gpconfigs/gprs_template
$ gpinitsystem -I /home/gpadmin/gpconfigs/gprs_template -n zh_CN.utf8 -m 100 -s host2.centos -P 5432 -S /data/gpdb/master

$ gpinitstandby -s host2.centos -P 5432 –hba-hostnames 1 -S /data/gpdb/master

$ gpstop -M smart -t 120
```
