webtalk_init -webtalk_dir H:/Desktop/OV7670_XY_ok1/OV7670_1/OV7670_1.hw/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Wed Aug 08 15:06:02 2018" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "Vivado v2015.2 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "1266856" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "WIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "labtool" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "0e11ebc2-3ab9-42f9-a8df-bc6a3454bf5b" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "7bd8a368-08b8-415c-b65e-c631e543ac23" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "17" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Microsoft Windows 8 or later , 64-bit" -context "user_environment"
webtalk_add_data -client project -key os_release -value "major release  (build 9200)" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "3408 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "8.000 GB" -context "user_environment"
webtalk_register_client -client labtool
webtalk_add_data -client labtool -key cable -value "Digilent/Basys3/15000000" -context "labtool\\usage"
webtalk_add_data -client labtool -key chain -value "0362D093" -context "labtool\\usage"
webtalk_add_data -client labtool -key pgmcnt -value "43:02:00" -context "labtool\\usage"
webtalk_add_data -client labtool -key cfgmem -value "s25fl032p-spi-x1_x2_x4" -context "labtool\\usage"
webtalk_transmit -clientid 1920549549 -regid "" -xml H:/Desktop/OV7670_XY_ok1/OV7670_1/OV7670_1.hw/webtalk/usage_statistics_ext_labtool.xml -html H:/Desktop/OV7670_XY_ok1/OV7670_1/OV7670_1.hw/webtalk/usage_statistics_ext_labtool.html -wdm H:/Desktop/OV7670_XY_ok1/OV7670_1/OV7670_1.hw/webtalk/usage_statistics_ext_labtool.wdm -intro "<H3>LABTOOL Usage Report</H3><BR>"
webtalk_terminate
