import QtQuick
import QtQuick.Layouts
Rectangle
{
    property int speed: 0
    width: 300
    height: 50
    color: "transparent"

        Text
        {
            text: "21 °C"
            color: "white"
            font.pixelSize: 20
            anchors.left: parent.left
            font.bold: true
             font.family: "protest guerrilla"

        }
        Text {
            id: centralText
            text: speed
            color: "white"
            font.pixelSize: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            font.bold: true
             font.family: "protest guerrilla"

        }
        Text {

            text: "km/h"
            color: "white"
            font.pixelSize: 15
            anchors.left: centralText.right
            anchors.leftMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            font.bold: true
             font.family: "protest guerrilla"

        }
        Text {
            id: timeText
            color: "white"
            font.pixelSize: 20
            anchors.right: parent.right
            font.bold: true
             font.family: "protest guerrilla"

            Component.onCompleted: {
                updateTime();
                var timer = Qt.createQmlObject('import QtQuick 2.15; Timer { interval: 1000; running: true; repeat: true; onTriggered: updateTime() }', timeText);
            }
        }
        Rectangle
        {
           height: 1
           width: 300
           anchors.top: centralText.bottom
           anchors.horizontalCenter: parent.horizontalCenter
           gradient: Gradient {
               GradientStop { position: 0.2 ; color: "black"}
               GradientStop { position: 0.5 ; color: "red"}
               GradientStop { position: 0.8 ; color: "black"}
               orientation: Qt.Horizontal
           }
        }
        function updateTime() {
            var currentTime = new Date();
            timeText.text = formatTime(currentTime);
        }
        function formatTime(date) {
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12;
            minutes = minutes < 10 ? '0' + minutes : minutes;
            return hours + ':' + minutes + ' ' + ampm;
        }



}
