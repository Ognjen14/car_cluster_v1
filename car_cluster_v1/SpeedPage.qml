import QtQuick
import QtQuick.Controls

Rectangle {
    id: rectBorder
    color: "transparent"
    anchors.fill: parent

    SpeedCluster{ id: speedCluster }
    RMPCluster{ id: rmpCluster }

    Timer {
        id: timer
        interval: 20
        running: true
        repeat: true
        property real maxAngle: 11 * Math.PI / 6
        property real minAngle: Math.PI / 3
        property real maxRevolutions: -2.6
        property real minRevolutions:  2 * Math.PI / 3
        property real directionSpeed: 1
        property real directionRevolutions: -1
        property real startAngleSpeed: Math.PI / 3

        onTriggered: {
            // Handle angleSpeed
            if (speedCluster.angleSpeed + (Math.PI / 180) * directionSpeed > maxAngle) {
                directionSpeed *= -1;
            } else if (speedCluster.angleSpeed + (Math.PI / 180) * directionSpeed < minAngle) {
                directionSpeed *= -1;
            }
            speedCluster.angleSpeed += (0.5 * Math.PI / 180) * directionSpeed;

            if (rmpCluster.angleRevolutions + ( Math.PI / 180) * directionRevolutions < maxRevolutions) {
                directionRevolutions = 1;

            } else if (rmpCluster.angleRevolutions + ( Math.PI / 180) * directionRevolutions >= minRevolutions) {
                directionRevolutions = -1;

            }
            rmpCluster.angleRevolutions += (0.5 * Math.PI / 180) * directionRevolutions;

            speedCluster.requestPrintFillCanvas();
            rmpCluster.requestPaintCanvasRight();

            var angleSpeed2= speedCluster.angleSpeed - startAngleSpeed

            infoPage.speed = angleSpeed2 * 180 /Math.PI
        }
    }

}






