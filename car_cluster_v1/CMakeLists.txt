cmake_minimum_required(VERSION 3.16)

project(car_cluster_v1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Quick3D)

qt_standard_project_setup()

qt_add_executable(car_cluster_v1
    main.cpp
)

qt_add_qml_module(car_cluster_v1
    URI car_cluster_v1
    VERSION 1.0
    SOURCES
    tcpclient.h
    tcpclient.cpp
    QML_FILES
    Main.qml
    MainMenu.qml
    MotorTemp.qml
    RMPCluster.qml
    SpeedCluster.qml
    CentralPanel.qml
    InfoPage.qml
    SpeedPage.qml
    Fuel.qml
    KilometerPage.qml
    RESOURCES
    Images/background.jpg
    Images/absIcon.png
    images/fuelIconOff.png
    images/fuelIconOn.png
    images/engineIcon.png
    images/iceIcon.png
    fonts/ProtestGuerrilla-Regular.ttf
    images/parkingBrakeIcon.png
    images/seatbeltIcon.png
    images/motorTemp.png
    images/woman.png
    images/albums/cyberpunk.jpg
    images/albums/appetite.jpg
)


target_link_libraries(car_cluster_v1
    PRIVATE Qt6::Quick
           Qt6::Quick3D
)
