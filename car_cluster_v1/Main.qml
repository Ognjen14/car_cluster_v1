import QtQuick
import QtQuick.Controls
import QtQuick3D
import TcpServer 1.0
Window {
    width: 800
    height: 420
    visible: true
    title: qsTr("Automotive Project")
    color: "black"
    minimumHeight: 420
    maximumHeight: 420
    minimumWidth: 800
    maximumWidth: 800

    //flags: Qt.FramelessWindowHint

    Receive
    {
        id: receive
        Component.onCompleted: {
               // Initiates the server start process for the 'receive' component on port 1234
               receive.startServer(1234);
           }
    }

    FontLoader
    {
        source: "fonts/ProtestGuerrilla-Regular.ttf"
    }

    Rectangle
    {
        anchors.fill: parent
        color: "transparent"
        Image {

            source: "Images/background.jpg"
            anchors.fill: parent
        }
        SpeedPage
        {

        }
        InfoPage
        {
            id: infoPage
            anchors
            {
                top:parent.top
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }

        }
        KilometerPage
        {
            anchors
            {
                bottom: centralPanel.top
                bottomMargin: 50
                horizontalCenter: parent.horizontalCenter
            }
        }

        CentralPanel
        {
            id :centralPanel
            anchors{
                top: parent.top
                topMargin: 300
                horizontalCenter: parent.horizontalCenter
            }
        }
        Fuel
        {
            anchors
            {
                bottom: parent.bottom
                bottomMargin: 30
                right: parent.right
                rightMargin: 30
            }

        }
        MotorTemp
        {
            anchors
            {
                bottom: parent.bottom
                bottomMargin: 30
                left: parent.left
                leftMargin: 30
            }
        }
    }


    MainMenu{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 70
    }


    Rectangle
    {
        color: "transparent"
        id: connector
        anchors.fill: parent
        Rectangle
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height/2 - 8
            id: line
            width: 280
            height: 10
            color:"#15e6e6"
            radius: 10
        }

        Rectangle
        {
            width: 50
            height: 10
            rotation: -36
            color:"#15e6e6"
            radius: 10
            anchors
            {
                right: line.left
                rightMargin: -10
                top: parent.top
                topMargin: 215
            }

        }
        Rectangle
        {
            width: 50
            height: 10
            rotation: 36
            color:"#15e6e6"
            anchors
            {
                left: line.right
                leftMargin: -10
                top: parent.top
                topMargin: 215
            }
            radius: 10
        }
    }


}







