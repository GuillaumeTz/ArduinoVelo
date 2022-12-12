cmake_minimum_required(VERSION 3.16)

project(ArduiVelo VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Core SerialPort Quick REQUIRED)

qt_add_executable(appArduiVelo
	QArduinoVelo.h
	QArduinoVelo.cpp
    main.cpp
)

qt_add_qml_module(appArduiVelo
	URI ArduiVelo
    VERSION 1.0
	QML_FILES main.qml CountersWidget.qml CountersWidgetForm.ui.qml
	IMPORT_PATH ./
)

set_target_properties(appArduiVelo PROPERTIES
	MACOSX_BUNDLE_GUI_IDENTIFIER com.ArduiVelo
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appArduiVelo
	PRIVATE Qt6::Core Qt6::Quick Qt6::SerialPort)

install(TARGETS appArduiVelo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
