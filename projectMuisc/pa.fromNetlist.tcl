
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name projectMuisc -dir "C:/Users/CMPE 3432/Downloads/project1125/projectMuisc/planAhead_run_4" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/CMPE 3432/Downloads/project1125/projectMuisc/Project.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/CMPE 3432/Downloads/project1125/projectMuisc} }
set_property target_constrs_file "prjconstra.ucf" [current_fileset -constrset]
add_files [list {prjconstra.ucf}] -fileset [get_property constrset [current_run]]
link_design
