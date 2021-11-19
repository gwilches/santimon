

use Config::IniFiles;
use Data::Dumper; 
chdir "/mnt/c/Users/egermwi/Documents/myScripts/dev/santimon_dev/";

#my %ini;
#tie %ini, 'Config::IniFiles', ( -file => "config.stm" );

$ini = Config::IniFiles->new( -file => "config.stm" );

$fecha=`date +"%Y-%m-%d %H:%M"":00" `;
chomp($fecha);





foreach my $component ($ini->Sections())
{
	
	if($component eq "General")
	{
		
		$loader=$ini->val($component,loader);
		$localPath=$ini->val($component,localPath);
	}

	
	print "$component\n";
	if($ini->val($component,type))
	{
		
		my $host = $ini->val($component,host);
		my $port=$ini->val($component,port);
		my $db_name=$ini->val($component,db_name);
		my $db_user=$ini->val($component,db_user);
		my $os_user=$ini->val($component,os_user);
						
		@playlists = $ini->val($component, 'playlist');

	
		foreach my $playlist (@playlists) 
		{

				
				my %TplIni;
				tie %TplIni, 'Config::IniFiles', ( -file => $playlist );
				
				foreach $item (keys %TplIni)
				{
					
				
					
					print $item."\n";
					$command=$TplIni{$item}{cmd}."\n";
					#Remplazo de variables importantes






					$command=~s/<host>/$host/g;
					$command=~s/<port>/$port/g;
					$command=~s/<db_name>/'$db_name'/g;
					$command=~s/<db_user>/'$db_user'/g;
					$command=~s/<os_user>/$os_user/g;
					$command=~s/<localPath>/$localPath/g;
					$command=~s/<itemName>/$item/g;

					print "comand:\n".$command."\n";
					my %result;
					$string="";
					@data=();
					eval($command);	
					#print $kpi;
					while (($item, $value) = each(%result))
					{
						$string.="&$item=$value";
						
					}
					$string.="&fecha=$fecha&none=none";
					
					$string2API= "$loader?hostname=".$ini->val($component,labelname)."$string\n";
					#print $string2API;
					`wget -q "$string2API" -O /dev/null`;
					
		}			
					






		}






		



	}




}
