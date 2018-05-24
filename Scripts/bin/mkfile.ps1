$path=$args[0]
$message = $args[1]
#$message = "$t_message"

if($path.ToString().StartsWith(".\")){
    Add-Content $path $message
}
if($path.ToString().StartsWith("C:\")){
    Add-Content $path $message
}
else{
    Add-Content ".\$path" $message
}