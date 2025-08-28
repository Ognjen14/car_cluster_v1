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
    property real angleFuel: Math.PI /4
    property int fuelLeft: 0

    Image {

        id: fuelImage
        source: "images/fuelIconOff.png"
        width: 25
        height: 25
        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 30
        }
    }
    Text
    {
        anchors
        {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 95
        }
        text: fuelLeft + " l"
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
            ctx.arc(parent.width / 2, parent.height / 2, circleSize ,7 * Math.PI /4 , Math.PI /4)
            ctx.lineWidth = 2
            ctx.lineCap = "round"
            ctx.strokeStyle = "white";
            ctx.stroke();


            var angleStep = (1.57) / 7;
            var radiusLine = rectFuel.circleSize - 7 / 2 + 5;
            ctx.lineWidth = 2
            for(var i = 0 ; i <= 7 ; i++)
            {
                ctx.strokeStyle = "white";
                var angle =7* Math.PI /4 + angleStep * i;

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
                var needleTipX = parent.width / 2 + needleLength * Math.cos(angleFuel);
                var needleTipY = parent.height / 2 + needleLength * Math.sin(angleFuel);

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
        id: timerFuel

        interval: 1
        running: true
        repeat: true
        property real maxAngle: -0.7603047484373363
        property real minAngle: Math.PI /4
        property real directionSpeed: -1

        onTriggered:
        {
            if (angleFuel + (Math.PI / 180) * directionSpeed < maxAngle)
            {
                directionSpeed = 1;
                timerFuel.interval = 300

            }else if(angleFuel + (Math.PI / 180) * directionSpeed >= minAngle)
            {
                directionSpeed = -1;
                timerFuel.interval = 5
            }
            angleFuel += (0.1 * Math.PI / 180) * directionSpeed;
            canvasNeedleFuel.requestPaint()



            if(angleFuel >= minAngle - Math.PI  / 6 )
            {
                fuelImage.source = "images/fuelIconOn.png"

            }else
            {
                fuelImage.source = "images/fuelIconOff.png"
            }

            fuelLeft = ( -angleFuel + minAngle ) * 180/Math.PI
        }
    }
}
