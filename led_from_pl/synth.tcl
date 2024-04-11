source -notrace ../script/proj_gen.tcl

proc create_target {} {
        # Get the current time as a Unix timestamp
        set currentTime [clock seconds]

        # Format the timestamp into the desired format
        set formattedTime [clock format $currentTime -format {%Y%m%d_%H%M%S}]

        set proj_name "kria_led_from_pl_example${formattedTime}_"
        
        set origin_dir "./hardware"
        
        # Set project info
        ::proj::set_proj_info                            \
            -force                                       \
            -part "xck26-sfvc784-2LV-c"                  \
            -board_part "xilinx.com:kr260_som:part0:1.1" \
            -addr "$origin_dir"                          \
            -name "$proj_name"

        ::proj::generate_project

        # Add source files
        ::proj::create_src_filesets -base_folder $origin_dir
        
        # Set top module
        set HDL_TOP_MODULE_NAME "kr260_top"
        ::proj::set_top_wrapper -file_name $HDL_TOP_MODULE_NAME

        # Add constraint files
        ::proj::create_constr_filesets -base_folder $origin_dir
        update_compile_order -fileset sources_1

        # Build the project
        puts "--- Building project"
        ::proj::build_proj
        
        wait_on_run impl_1

        puts "--- Export bitstream"
        set xil_proj [::proj::get_project_name]
        ::proj::export_proj_bitstream -destination "$origin_dir/build/export_${xil_proj}"
        
    }

