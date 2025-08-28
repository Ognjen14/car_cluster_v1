import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects
Rectangle {
    id: rectFuel
    width: 150
    height: 150
    color: "transparent"
    property int circleSize: 70
    property int lineLenght:  10
    property real angleTemp:3 * Math.PI /4
    property int temperature: 70

    Image {

        id: motorTempImage
        source: "images/motorTemp.png"
        width: 30
        height: 30
        anchors
        {
           verticalCenter: parent.verticalCenter
           left: parent.left
           leftMargin: 30
        }
        ColorOverlay
        {
            id: colorOverlay

            anchors.fill: motorTempImage
            source:motorTempImage
            color: "white"
        }
    }

    Text
    {
        anchors
        {
           verticalCenter: parent.verticalCenter
           left: parent.left
           leftMargin: 95
        }
        text: temperature + " °C"
        color: "#7a7d7a"
        font.bold: true
        font.pixelSize: 22
         font.family: "protest guerrilla"

    }

    Canvas {
        id: fuelCanvas
        anchors.fill: parent
        onPaint:
        {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSize ,3 * Math.PI /4 , 5* Math.PI /4)
            ctx.lineWidth = 2
            ctx.lineCap = "round"
            ctx.strokeStyle = "white";
            ctx.stroke();


            var angleStep = (5* Math.PI /4 -3 * Math.PI /4 ) / 7;
            var radiusLine = rectFuel.circleSize - 7 / 2 + 5;
            ctx.lineWidth = 2
            for(var i = 0 ; i <= 7 ; i++)
            {
                ctx.strokeStyle = "white";
                var angle =3 * Math.PI /4 + angleStep * i;

                lineLenght = 20
                ctx.lineWidth = 2

                if(i == 0)
                {
                    ctx.lineWidth = 3
                    lineLenght = 20

                }else if (i == 3)
                {
                    ctx.lineWidth = 3
                    lineLenght = 20

                }else if(i == 7)
                {
                    ctx.lineWidth = 8
                    lineLenght = 20
                    ctx.strokeStyle = "red";

                }else if( i == 6)
                {
                  ctx.strokeStyle = "red";
                    ctx.lineWidth = 6
                }else if (i == 5)
                {
                     ctx.lineWidth = 3
                    ctx.strokeStyle = "red";
                }

                var lineStartX = parent.width / 2 + (radiusLine -10) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (radiusLine -10) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (radiusLine - lineLenght) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (radiusLine -lineLenght) * Math.sin(angle);



                ctx.beginPath();
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();
            }

        }
    }

    Rectangle {
        width: 150
        height: 150
        color: "transparent"
        anchors.centerIn: rectFuel
        Rectangle
        {
            anchors.centerIn: parent
            width: 30
            height: 30
            radius: 15
            opacity: 0.4
            gradient: Gradient {
                GradientStop { position: 0.0 ; color : "#232526"}
                GradientStop { position: 1.0 ; color : "#414345"}
            }

        }

        Canvas {
            id: canvasNeedleFuel
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                var needleLength = 60;
                var needleWidth = 3;
                var needleTipX = parent.width / 2 + needleLength * Math.cos(angleTemp);
                var needleTipY = parent.height / 2 + needleLength * Math.sin(angleTemp);

                var gradient = ctx.createLinearGradient(parent.width / 2, parent.height / 2, needleTipX, needleTipY);
                gradient.addColorStop(0, "white");
                gradient.addColorStop(1, "red");

                ctx.beginPath();
                ctx.moveTo(parent.width / 2, parent.height / 2);
                ctx.lineTo(needleTipX, needleTipY);
                ctx.lineWidth = needleWidth;
                ctx.lineCap = "round";
                ctx.strokeStyle = gradient;
                ctx.stroke();
            }
        }
    }


    Timer
    {
        id: timerTemp

        interval: 1
        running: true
        repeat: true
        property real maxAngle: 5* Math.PI /4
        property real minAngle: 3* Math.PI /4
        property real directionSpeed: 1 // 1 for increasing, -1 for decreasing
        property real startAngleSpeed: 3* Math.PI /4

        onTriggered:
        {
                if (angleTemp + (Math.PI / 180) * directionSpeed >= maxAngle)
                {
                    directionSpeed = -1;
                    timerTemp.interval = 40

                }else if(angleTemp + (Math.PI / 180) * directionSpeed <= minAngle)
                {
                     directionSpeed = 1;
                }
                angleTemp += (0.1 * Math.PI / 180) * directionSpeed;
                canvasNeedleFuel.requestPaint()

                if(angleTemp >= maxAngle - Math.PI / 6)
                {
                    colorOverlay.color = "red"

                }else
                {
                     colorOverlay.color = "white"
                }
                temperature = 70 + (angleTemp - startAngleSpeed) * 180 / Math.PI

        }
    }
}
