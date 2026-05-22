cmake_minimum_required(VERSION 3.16)

project(ASCEND_GUI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core)

qt_standard_project_setup()

set(APP_ICON_RESOURCE_WINDOWS "${CMAKE_CURRENT_SOURCE_DIR}/app_icon.rc")

qt_add_executable(appASCEND_GUI
    main.cpp

    SolverBridge.h
    SolverBridge.cpp

    core/config.h
    core/config.cpp
    core/input.h
    core/input.cpp
    core/solver.h
    core/solver.cpp
    core/util.h
    core/util.cpp

    ${APP_ICON_RESOURCE_WINDOWS}
)

qt_add_qml_module(appASCEND_GUI
    URI ASCEND_GUI
    VERSION 1.0
    QML_FILES
        Main.qml
    RESOURCES
        assets/anvil_bg.png
        assets/moves/-3.png
        assets/moves/-6.png
        assets/moves/+2.png
        assets/moves/+7.png
        assets/moves/-9.png
        assets/moves/-15.png
        assets/moves/+13.png
        assets/moves/+16.png

        assets/ui/plan_icon.png

        assets/ui/red_marker.png
        assets/ui/green_marker.png

        assets/ui/final_slots/final_slot_left.png
        assets/ui/final_slots/final_slot_middle.png
        assets/ui/final_slots/final_slot_right.png

        assets/ui/app_icon.ico
)

target_link_libraries(appASCEND_GUI
    PRIVATE
        Qt6::Quick
        Qt6::Core
)
