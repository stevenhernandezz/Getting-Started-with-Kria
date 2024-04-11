set platform_name "proj_platform"
set domain_name "proj_domain"
set app_name "proj_app"
set xsa_location "../hardware/export/system_wrapper.xsa"

puts "set the workstation directory"
setws .

puts "Create a platform"
platform create -name $platform_name -hw $xsa_location

puts "Create a domain"
domain create -name $domain_name -os standalone -proc psu_cortexa53_0

puts "Build platform"
platform -generate

puts "Create an application"
app create -name $app_name -platform $platform_name -domain $domain_name -template "Empty Application(C)"
