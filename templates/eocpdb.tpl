[_APPE_ALL]
cmd=@data=();$kpi=`psql -h <host> -p <port> -d <db_name> -U <db_user> -f <localPath>/items/<itemName>  | grep -v count | grep -v '-' | grep -v "(" | perl -pe 's/ //g'`;@data=split(/\n/,$kpi);foreach $line (@data){  chomp($line);if($line=~/(\w+)\|(\d+)/){$result{$1}=$2;}}


[_AVMS]
cmd=@data=();$kpi=`psql -h <host> -p <port> -d <db_name> -U <db_user> -tf <localPath>/items/<itemName>  | grep -v count | grep -v "(" | perl -pe 's/  //g'`;@data=split(/\n/,$kpi);foreach $line (@data){chomp($line);if($line=~/([^\|]+)\|([^\n]+)/){$result{$1}=$2;}}


[_EOCMT]
cmd=@data=();$kpi=`psql -h <host> -p <port> -d <db_name> -U <db_user> -tf <localPath>/items/<itemName>  | tr "\n" ">"`;if($kpi){$kpi=~s/\s//g;$result{'eoc_mt'}=$kpi;}

[_EOCORD1]
cmd=@data=();$kpi=`psql -h <host> -p <port> -d <db_name> -U <db_user> -tf <localPath>/items/<itemName> |  grep -v '-' | grep -v row | perl -pe 's/ //g'`; print 'nada mas'; @data=split(/\n/,$kpi);foreach $line (@data){chomp($line);    if($line=~/(\w+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)/){$cadena_status_ordenes=$2.",".$3.",".$4.",".$5.",".$6.",".$7.",".$8;$result{'ordenes_'.$1}=$cadena_status_ordenes;if($line=~/"GrandTotal\|\|\|\|\|\|\|"/)  {$result{'ordenes_GrandTotal'}="|0|0|0|0|0|0|";}}}


