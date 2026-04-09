cmake_minimum_required(VERSION 3.5)
project(SailTuner)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5 REQUIRED COMPONENTS Qml Quick Gui Multimedia DBus)
find_package(PkgConfig REQUIRED)
pkg_check_modules(PULSEAUDIO REQUIRED libpulse libpulse-simple)

add_compile_definitions(TARGET="${PROJECT_NAME}")

set(SOURCES
    src/desktop.cpp
    src/ObjectSaver.cpp
    src/PitchDetection.cpp
    src/Tuner.cpp
    src/TunerWorker.cpp
    src/audio/FreqPlayer.cpp
    src/audio/LinearFilter.cpp
    src/audio/ZeroCross.cpp
    src/scale/Scale.cpp
    src/scale/Temperaments.cpp
)

set(HEADERS
    src/PitchDetection.hpp
    src/ObjectSaver.hpp
    src/Tuner.hpp
    src/TunerWorker.hpp
    src/audio/FreqPlayer.hpp
    src/audio/LinearFilter.hpp
    src/audio/ZeroCross.hpp
    src/scale/Scale.hpp
    src/scale/Temperaments.hpp
)

set(RESOURCES
    qml/desktop.qrc
    data/temperaments.qrc
    images/desktop/images.qrc
)

add_executable(${PROJECT_NAME}
    ${SOURCES}
    ${HEADERS}
    ${RESOURCES}
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${PULSEAUDIO_INCLUDE_DIRS}
)

set(DATA_DIR /)
set(DESKTOP_FILE_NAME ${PROJECT_NAME}.desktop)


configure_file(manifest.json.in ${CMAKE_CURRENT_BINARY_DIR}/manifest.json)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/manifest.json DESTINATION ${CMAKE_INSTALL_PREFIX})
install(FILES ${PROJECT_NAME}.apparmor DESTINATION ${DATA_DIR})
install(FILES ${DESKTOP_FILE_NAME} DESTINATION ${DATA_DIR})
install(FILES icons/harbour-sailtuner.svg DESTINATION assets)
install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX})


target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt5::Qml
    Qt5::Quick
    Qt5::Gui
    Qt5::Multimedia
    Qt5::DBus
    ${PULSEAUDIO_LIBRARIES}
)

target_compile_options(${PROJECT_NAME} PRIVATE
    ${PULSEAUDIO_CFLAGS_OTHER}
)