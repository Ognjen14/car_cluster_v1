import QtQuick

Rectangle
{
    width: 250
    height: 40
    color: "transparent"

    Text {
        id: totalKM
        text: qsTr("147555 km")
        font.pixelSize: 25
        font.bold: true
        font.family: "protest guerrilla"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
    }
    Text {
        id: currentKM
        text: qsTr("687 km")
        font.pixelSize: 25
        font.bold: true
        font.family: "protest guerrilla"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
    }
}
