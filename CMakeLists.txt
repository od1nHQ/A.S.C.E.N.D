cmake_minimum_required(VERSION 3.16)

project(ASCEND_GUI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core)

qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)

set(APP_ICON_RESOURCE_WINDOWS "${CMAKE_CURRENT_SOURCE_DIR}/app_icon.rc")

# ===================== TEMPLATE ITEM IMAGES =====================
# Автоматично збирає всі PNG з:
# assets/templates/items/
#
# Наприклад:
# assets/templates/items/pickaxe_head/copper.png
# assets/templates/items/axe_head/steel.png
#
# CONFIGURE_DEPENDS означає:
# якщо додати нові PNG, CMake має підтягнути їх після пере-конфігурації.
file(GLOB_RECURSE TEMPLATE_ITEM_IMAGES
    CONFIGURE_DEPENDS
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_SOURCE_DIR}/assets/templates/items/*.png"
)

qt_add_executable(appASCEND_GUI
    main.cpp

    SolverBridge.h
    SolverBridge.cpp

    TemplateData.h
    TemplateStorage.h
    TemplateStorage.cpp
    TemplateBridge.h
    TemplateBridge.cpp

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

set_target_properties(appASCEND_GUI PROPERTIES
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME "A.S.C.E.N.D"
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

        ${TEMPLATE_ITEM_IMAGES}
        SOURCES TemplateData.h
        SOURCES TemplateStorage.h
        SOURCES TemplateStorage.cpp
        SOURCES TemplateBridge.h
        SOURCES TemplateBridge.cpp
)

target_link_libraries(appASCEND_GUI
    PRIVATE
        Qt6::Quick
        Qt6::Core
)
