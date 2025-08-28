import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
Rectangle
{
    width: 300
    height: 55
    color: "transparent"
    border.width: 2
    border.color: "white"
    radius: 10
    RowLayout{
        anchors.centerIn: parent
        Rectangle {
             color: "transparent"
            width: 40
            height: 40
            Image {
                id: engineImage
                anchors.fill: parent

                source: "images/engineIcon.png"

                ColorOverlay
                {
                    id: colorOverlayEngine

                    anchors.fill: engineImage
                    source:engineImage
                    color: "white"
                }
            }
        }
        Rectangle {
            width: 40
            height: 40
             color: "transparent"
            Image{
                id: seatBeltImage

                source:"images/seatbeltIcon.png"
                anchors.fill: parent
                ColorOverlay
                {


                    anchors.fill: seatBeltImage
                    source:seatBeltImage
                    color: "red"
                }

            }
        }
        Rectangle {
            width: 40
            height: 40
             color: "transparent"
            Image{
                id: absImage

                source:"Images/absIcon.png"
                anchors.fill: parent
                ColorOverlay
                {
                    anchors.fill: absImage
                    source:absImage
                    color: "white"
                }

            }
        }
        Rectangle {
            width: 40
            height: 40
             color: "transparent"
            Image{
                id: iceImage

                source:"images/iceIcon.png"
                anchors.fill: parent
                ColorOverlay
                {

                    anchors.fill: iceImage
                    source:iceImage
                    color: "white"
                }
            }
        }
    }
}
