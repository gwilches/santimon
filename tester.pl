
@data=();
$kpi=`psql -h '10.156.37.46' -p '5444' -d 'eocpdb' -U 'eocpuser' -tf /mnt/c/Users/egermwi/Documents/myScripts/dev/santimon/items/_EOCORD1 |  grep -v '-' | grep -v row | perl -pe 's/ //g'`; 
print 'nada mas'; 
@data=split(/\n/,$kpi);
foreach $line (@data)
{
    chomp($line);    
    if($line=~/(\w+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)\|(\d+)/)
    {
        $cadena_status_ordenes=$2.",".$3.",".$4.",".$5.",".$6.",".$7.",".$8;
        $result{'ordenes_'.$1}=$cadena_status_ordenes;
        if($line=~/"GrandTotal\|\|\|\|\|\|\|"/)  
        {


            $result{'ordenes_GrandTotal'}="|0|0|0|0|0|0|";
        }
    }
}