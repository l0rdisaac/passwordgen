# https://superuser.com/a/1617838
# By Isaac Lord and Ξένη Γήινος

$randomstring=for ($i=0;$i -lt 64;$i++) {
    [char]$(Get-Random -Min 48 -Max 57)
}
$randomstring=$randomstring -join ""
$randomstring
