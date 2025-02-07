# https://superuser.com/a/1617838
# By Isaac Lord and Ξένη Γήινος

[array]$symbols=@('+','²','&','é','"','(','-','è','_','ç','à',')','=','^','$','*','ù',',',';',':','!','¨','£','µ','%','?','.','/','§','°','+','~','#','{','[','|','`','\','^','@',']','}','¤')
$numgroups=9

$lenopt = $host.ui.PromptForChoice('Length', "0 = 08`n1 = 16`n2 = 32`n3 = 64", (0, 1, 2, 3), 2)

switch ($lenopt) {
    0 {
        $pwlength = 8
        $numgroups = 8
    }
    1 { $pwlength = 16 }
    2 { $pwlength = 32 }
    3 { $pwlength = 64 }
}

$hasall=0 # output includes each char type
[int]$timestried=1 # number of passwords made, including the good password

function Setgroup {
    param (
            [int]$groupnum
    )
    
    $group[$groupnum]=1
}

while ($hasall -ne 1) {
    $group=New-Object System.Collections.Generic.List[System.Object]
    for ($i=0;$i -lt $numgroups;$i++) {
        $group.Add(0)
    }
    
    $randomstring=for ($i=0;$i -lt $pwlength;$i++) {
        $gpchoice=$(get-securerandom -min 0 -max 99) % $numgroups
        switch ($gpchoice)
        {
            0 {[char]$(get-securerandom -Min 65 -Max 90) && Setgroup($gpchoice)} # CAPITAL
            1 {[char]$(get-securerandom -Min 97 -Max 122) && Setgroup($gpchoice)} # lowercase
            2 {$symbols[$(get-securerandom -Min 0 -Max $($symbols.count-1))] && Setgroup($gpchoice)} # symbols array
            3 {$(get-securerandom -Min 0 -Max 9) && Setgroup($gpchoice)} # number
            4 {[char]$(get-securerandom -Min 33 -Max 47) && Setgroup($gpchoice)} # ascii special char group 1
            5 {[char]$(get-securerandom -Min 58 -Max 64) && Setgroup($gpchoice)} # ascii special char group 2
            6 {[char]$(get-securerandom -Min 91 -Max 96) && Setgroup($gpchoice)} # ascii special char group 3
            7 {[char]$(get-securerandom -Min 123 -Max 126) && Setgroup($gpchoice)} # ascii special char group 4
            8 {[char]$(get-securerandom -Min 128 -Max 254) && Setgroup($gpchoice)} # ascii special char group 5
        }
    }
    
    # check if all groups have a char from the group
    $hasall=1
    
    for ($i=0;$i -lt $numgroups;$i++) {
        if ($group[$i] -eq 0) {
            $hasall=0
        }
    }
    
    # Tells me if it had to make a new password because missing one group
    if ($hasall -eq 1) {
        break
    } else {
        $script:timestried++
        # "Try again"
    }
}
[string]$timestried + " attempt"

$randomstring=$randomstring -join ""
$randomstring
