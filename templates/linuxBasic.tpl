[_UPTIME]
cmd=$kpi=`ssh -q <os_user>\@<host> -p <port> -C "echo -n \"Load=\"; uptime"`;if($kpi=~/Load=\s([^,]+),\s+([^,]+),\s+([^,]+),\s+[^:]+:\s+([^,]+),/){$uptime1=$1;$uptime2=$2;$q_users=$3;$load_average=$4;if($q_users=~/(\d+)/){$q_users=$1;}$result{'InfraBasic_Load'}=$load_average;$result{'InfraBasic_uptime'}="$uptime1 $uptime2";$result{'InfraBasic_Qusers'}=$q_users;}

[_MEM]
cmd=$kpi=`ssh -q <os_user>\@<host> -p <port> -C "free -g | grep -v total | awk '{print \\\$1,\\\$2,\\\$3,\\\$4}'"`;@data=split(/\n/,$kpi);foreach $line (@data){    chomp($line);    if($line=~/([^:]+):\s(\d+)\s(\d+)\s(\d+)/)    {      $kpi_name=$1;      $kpiString="$2,$3,$4";      $result{'InfraBasic_'.$kpi_name}=$kpiString;     }}

[_CPUUTI]
cmd=$kpi=`ssh -q <os_user>\@<host> -p <port> -C "sar 3 1 | grep Average | awk '{print \\\$NF}'"`;@data=split(/\n/,$kpi);foreach $line (@data){chomp($line);$result{'InfraBasic_cpuUsage'}=$line; }

