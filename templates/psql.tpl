[_OTXID]
cmd=@data=();$kpi=`psql -h <host> -p <port> -d <db_name> -U <db_user> -f <localPath>/items/<itemName>  | grep -v perce | grep -v '-' | grep -v row | perl -pe 's/ //g'`; if($kpi=~/(\d+)\|(\d+)\|(\d+)/) { $result{"oldest_current_xid"}=$1;$result{"percent_towards_wraparound"}=$2;$result{"percent_towards_emergency_autovacuum"}=$3;}

[_PGST]
cmd=@data=();$kpi=`psql -h <host> -p <port> -d <db_name> -U <db_user> -f <localPath>/items/<itemName>  | grep -v count | grep -v '-' | grep -v "(" | perl -pe 's/ //g'`;@data=split(/\n/,$kpi);foreach $line (@data){chomp($line);if($line=~/(\w+)\|(\d+)/){$result{$1}=$2;}}

[_MXIDTB]
cmd=@data=();$kpi=`psql -h <host> -p <port> -d <db_name> -U <db_user> -tf <localPath>/items/<itemName> | awk '{print \$1,\$3}'`;@data1=split(/\n/,$kpi);foreach $line (@data1){   chomp($line);   if($line)   {      $result{"MaxTableID"}.=$line."<br>";   }}    



