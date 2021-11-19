
[_DF]
cmd=@data=();$kpi=""; $kpi=`ssh -q <os_user>\@<host> -p <port> -C "df -h | awk '{print \\\$6,\\\$5,\\\$4}'"`;@data=split(/\n/,$kpi);foreach $line (@data){    chomp($line);    if($line=~/([^\s]+)\s([^\s]+)/)  {      $kpi_name='df_h_'.$1;      $kpiString=$2;      $result{'InfraBasic_'.$kpi_name}=$kpiString;     }}

[_Veritas_Partial]
cmd=@data=();$kpi="";$kpi=`ssh -q <os_user>\@<host> -p <port> -qC "sudo hastatus -sum | grep -i faul | awk '{print \\\$2,\\\$3}'  | perl -pe 's/\n/<br>/;'"`;chomp($kpi); $result{'Veritas_faulted'}=$kpi; 

[_OCCIn]
cmd=@data=();$kpi="";$kpi=`ssh -q <os_user>\@<host> -p <port> -qC "sudo find /var/opt/mediation/MMWorking4/sftp/charging/occprod/incoming/ | wc -l"`;chomp($kpi); $result{'EstEMM_OCCIn'}=$kpi; 

[_OCCBacklog]
cmd=@data=();$kpi="";$kpi=`ssh -q <os_user>\@<host> -p <port> -qC "	sudo find /var/opt/mediation/MMWorking4/sftp/charging/occprod/incoming_20210710/ | wc -l"`;chomp($kpi); $result{'EstEMM_OCCBacklog'}=$kpi; 

[_OCCBacklogJun]
cmd=@data=();$kpi="";$kpi=`ssh -q <os_user>\@<host> -p <port> -qC "	sudo find /var/opt/mediation/MMStorage4/Server4/CXC1741717_R2N/storage/inbuffer/ -name '*202106*'  | wc -l"`;chomp($kpi); $result{'EstEMM_OCCBacklog_Jun'}=$kpi; 

[_OCCBacklogJul]
cmd=@data=();$kpi="";$kpi=`ssh -q <os_user>\@<host> -p <port> -qC "	sudo find /var/opt/mediation/MMStorage4/Server4/CXC1741717_R2N/storage/inbuffer/ -name '*202107*'  | wc -l"`;chomp($kpi); $result{'EstEMM_OCCBacklog_Jul'}=$kpi; 
