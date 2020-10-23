
FUNCTION menu {
	write-host "
	1
	2
	3
	4"
	$a = Read-host 
	switch($a){
		1 { um }
		2 { dois }
		3 { tres }
		4 { quatro }
	}
}

FUNCTION um {
	cls
	write-host vc escolheu o menu 1
	menu
}

FUNCTION dois {
	cls
	write-host vc escolheu o menu 2
	menu
}

FUNCTION tres {
	cls
	write-host vc escolheu o menu 3
	menu
}

FUNCTION quatro {
	cls
	write-host vc escolheu o menu 4
	menu
}





menu