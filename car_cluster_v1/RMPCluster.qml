import QtQuick

Rectangle {
    id: rightRect
    width: 250
    height: 250
    color: "transparent"

    property int circleSize: 120
    property int borderWidth: 10
    property string colorTest: "#373837"
    property string colorTest2: "#373837"
    property real angleRevolutions: 2*Math.PI / 3
    anchors {
        right: parent.right
        rightMargin: 20
        top: parent.top
        topMargin: 20
    }
    Canvas {
        id: canvasRight
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSize, 7 * Math.PI / 6, 2 * Math.PI / 3);
            ctx.lineWidth =borderWidth;
            ctx.lineCap = "round";

            var gradient = ctx.createLinearGradient(0, 250, 50, 0);
            gradient.addColorStop(0.3, colorTest);
            gradient.addColorStop(1, colorTest2);
            ctx.strokeStyle = gradient;
            ctx.stroke();

            // Draw indicator lines (white)
            ctx.strokeStyle = "white";
            ctx.lineWidth = 2;

            var angleStep = ( 2 * Math.PI / 3-  7 * Math.PI / 6) / 2.65;
            var radiusLine = circleSize - borderWidth / 2 + 5;
            var radiusNumbers = circleSize - borderWidth / 2 - 30;
            for (var i = 0; i <= 8; i++) {


                var angle = 2 *Math.PI / 3 + angleStep * i;
                var x = parent.width / 2 + radiusNumbers * Math.cos(angle);
                var y = parent.height / 2 + radiusNumbers * Math.sin(angle);

                // Draw white indicator lines
                var lineStartX = parent.width / 2 + (radiusLine - 10) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (radiusLine - 10) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (radiusLine - 20) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (radiusLine - 20) * Math.sin(angle);
                switch (i) {
                case 0:
                    ctx.strokeStyle = "red";
                    break;
                case 3:
                    ctx.strokeStyle = "#F9D423";
                    break;
                case 4:
                    ctx.strokeStyle = "#F09819";
                    break;
                case 5:
                case 6:
                    ctx.strokeStyle = "#FF512F";
                    break;
                default:
                    if (i > 6) {
                        ctx.strokeStyle = "red";
                    } else {
                        ctx.strokeStyle = "#5FC3E4";
                    }
                    break;
                }


                if (i < 8) {

                    var angleStep2 = angleStep / 6; // Angle step for gray lines

                    for (var j = 0; j < 6; j++) {
                        var grayLineStartX = parent.width / 2 + (radiusLine - 10) * Math.cos(angle + angleStep2 * j);
                        var grayLineStartY = parent.height / 2 + (radiusLine - 10) * Math.sin(angle + angleStep2 * j);
                        var grayLineEndX = parent.width / 2 + (radiusLine - 15) * Math.cos(angle + angleStep2 * j);
                        var grayLineEndY = parent.height / 2 + (radiusLine - 15) * Math.sin(angle + angleStep2 * j);

                        ctx.beginPath();
                        ctx.moveTo(grayLineStartX, grayLineStartY);
                        ctx.lineTo(grayLineEndX, grayLineEndY);
                        ctx.stroke();
                    }
                }


                ctx.strokeStyle = "white";
                ctx.beginPath();
                ctx.moveTo(lineStartX, lineStartY);
                ctx.lineTo(lineEndX, lineEndY);
                ctx.stroke();


                ctx.fillStyle = "white";
                ctx.font = "16px impact";
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";
                ctx.fillText(i.toString(), x, y);
            }
        }
    }
    Rectangle {
        id: rightRectFill
        width: 250
        height: 250
        color: "transparent"
        Canvas {
            id: canvasRightFill
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.beginPath();
                ctx.arc(parent.width / 2, parent.height / 2, circleSize, 2*Math.PI /3, angleRevolutions, true);
                ctx.lineWidth = borderWidth;
                ctx.lineCap = "round";

                var gradient = ctx.createLinearGradient(0, 250, 50, 0);
                gradient.addColorStop(0.3, "#15e6e6");
                gradient.addColorStop(1, "#b20a2c");
                ctx.strokeStyle = gradient;
                ctx.stroke();
            }
        }
    }
    Rectangle {
        width: 250
        height: 250
        color: "transparent"
        anchors.centerIn: rightRect
        Rectangle
        {
            id: rectCenterNeedle
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
        Text {
            id: rmpText
            text: qsTr("RMP")
            anchors
            {
                left: rectCenterNeedle.right
                leftMargin: 10
                 verticalCenter: parent.verticalCenter
            }
            color: "gray"
        }
        Text {
            text: qsTr("x  1000")
            anchors
            {
                left: rectCenterNeedle.right
                leftMargin: 10
                top: rmpText.bottom
                topMargin: 1
            }
            color: "gray"
        }

        Canvas {
            id: canvasNeeadleRight
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                var needleLength = 122;
                var needleWidth = 2;
                var needleTipX = parent.width / 2 + needleLength * Math.cos(angleRevolutions);
                var needleTipY = parent.height / 2 + needleLength * Math.sin(angleRevolutions);

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

    function requestPaintCanvasRight()
    {
        canvasNeeadleRight.requestPaint();
        canvasRightFill.requestPaint();
    }


}
