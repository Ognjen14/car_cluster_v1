import QtQuick
import QtQuick.Controls
Rectangle
{
    width: 250
    height: 150
    color: "transparent"
    property int replace: 1

    StackView
    {
        id: mainStack
        anchors.fill: parent
        initialItem: statistic
        replaceEnter: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 500 }
        }

        replaceExit: Transition {
            NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 500 }
        }
    }

    Component
    {
        id: musicComponenet
        Rectangle
        {

            color: "transparent"

            Image
            {
                anchors
                {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                }
                width: 90
                height: 90
                id: songImage
                source: "images/albums/appetite.jpg"

            }
            Text
            {
                anchors
                {
                    top: parent.top
                    topMargin: 55
                    left: songImage.right
                    leftMargin: 5

                }

                id: songArtist
                text: "Guns N' Roses"
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
            }
            Text
            {
                id: songName
                text: "Sweet Child o' Mine"
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
                anchors{
                    top: songArtist.bottom
                    left: songImage.right
                    leftMargin: 5
                }
            }
        }
    }

    Component
    {
        id: caller
        Rectangle{

            color: "transparent"
            Image
            {
                anchors
                {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                }
                width: 90
                height: 90
                id: songImage
                source: "images/woman.png"
            }
            Text
            {
                anchors
                {
                    top: parent.top
                    topMargin: 45
                    left: songImage.right
                    leftMargin: 5

                }

                id: songArtist
                text: "Someones Calling"
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
            }
            Text
            {
                id: songName
                text: "Incoming call..."
                font.family: "protest guerrilla"
                font.bold: true
                font.pixelSize: 17
                color: "white"
                anchors{
                    top: songArtist.bottom
                    left: songImage.right
                    leftMargin: 5
                }
            }
        }
    }

    Timer
    {
        interval: 5000
        running: true
        repeat: true

        onTriggered:
        {
            if(replace === 1)
            {
                mainStack.replace(musicComponenet)
                replace = 2

            }else if( replace == 2)
            {
                mainStack.replace(caller)
                replace = 3

            }else if(replace == 3)
            {
                mainStack.replace(statistic)
                replace = 1
            }
        }
    }

    Component {
        id: statistic
        Rectangle {
            color: "transparent"
            Grid {
                anchors.centerIn: parent
                rows: 4
                columns: 2
                columnSpacing: 5

                Text {
                    text: "Avg Speed:"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }

                Text {
                    text: "120 mph"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }

                Text {
                    text: "Fuel Cons.:"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }

                Text {
                    text: "8.7 L/100km"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }

                Text {
                    text: "Eng. Displ.:"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }

                Text {
                    text: "2.0L"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }

                Text {
                    text: "Accel. (0-60):"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }

                Text {
                    text: "6.5 sec"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "protest guerrilla"
                    color: "white"
                }
            }
        }
    }

}
