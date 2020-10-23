$file = ".\2019-08-23-24h.csv"
<#
Get-Content $file | Measure-Object -Line
$a = (Get-Content $file | Measure-Object)
(Get-Content $file) | ? {($a.count-1)-notcontains $_.ReadCount} | Set-Content $file #>


#				$text = import-csv $file -delimiter ";"
#				$text | select-object -SkipLast 1 | export-csv $file -notypeinformation
				
				
    $text = Get-Content $file | Select -SkipLast 1 
	$text | set-Content $file
