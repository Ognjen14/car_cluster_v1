import QtQuick

Rectangle {
    id: leftRect
    width: 250
    height: 250
    color: "transparent"

    property int circleSize: 120
    property int borderWidth: 10
    property string colorTest: "#373837"
    property string colorTest2: "#373837"

    property real angleSpeed: Math.PI / 3
    anchors {
        left: parent.left
        leftMargin: 20
        top: parent.top
        topMargin: 20
    }
    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(parent.width / 2, parent.height / 2, circleSize, Math.PI / 3, 11 * Math.PI / 6 );
            ctx.lineWidth = borderWidth;
            ctx.lineCap = "round";
            var gradient = ctx.createLinearGradient(217.88, 12.11, 217.88, 217.88);
            gradient.addColorStop(0.3, colorTest2);
            gradient.addColorStop(1, colorTest);
            ctx.strokeStyle = gradient;
            ctx.stroke();

            ctx.lineWidth = 2;

            var angleStep = (11 * Math.PI / 6  - Math.PI / 3) / 260;
            var radiusLine = circleSize - borderWidth / 2 + 5;
            var radiusNumbers = circleSize - borderWidth / 2 - 30;

            for (var i = 0; i <= 260; i += 20) {
                var angle = Math.PI / 3 + angleStep * i;
                var x = parent.width / 2 + radiusNumbers * Math.cos(angle);
                var y = parent.height / 2 + radiusNumbers * Math.sin(angle);

                // Draw white indicator lines
                var lineStartX = parent.width / 2 + (radiusLine - 10) * Math.cos(angle);
                var lineStartY = parent.height / 2 + (radiusLine - 10) * Math.sin(angle);
                var lineEndX = parent.width / 2 + (radiusLine - 20) * Math.cos(angle);
                var lineEndY = parent.height / 2 + (radiusLine - 20) * Math.sin(angle);
                if (i < 260 ) {

                    var angleStep2 = angleStep * 4;
                    ctx.strokeStyle = "#696969";

                    for (var j = 0; j < 5; j++) {
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
                ctx.font = "14px impact";
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";
                ctx.fillText(i.toString(), x, y);

            }
        }
    }
    Rectangle {
        id: leftRectFill
        anchors.fill: parent
        color: "transparent"
        Canvas {
            id: canvasLeftFIll
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.beginPath();
                ctx.arc(parent.width / 2, parent.height / 2, circleSize, Math.PI / 3, angleSpeed );
                ctx.lineWidth = borderWidth;
                ctx.lineCap = "round";
                var gradient = ctx.createLinearGradient(217.88, 12.11, 217.88, 217.88);
                gradient.addColorStop(0.3, "#b20a2c");
                gradient.addColorStop(1, "#15e6e6");
                ctx.strokeStyle = gradient;
                ctx.stroke();
            }
        }
    }
    Rectangle {
        width: 250
        height: 250
        color: "transparent"
        anchors.centerIn: leftRect
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
            id: canvasNeedleLeft
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                var needleLength = 122;
                var needleWidth = 2;
                var needleAngle = Math.PI / 3;
                var needleTipX = parent.width / 2 + needleLength * Math.cos(angleSpeed);
                var needleTipY = parent.height / 2 + needleLength * Math.sin(angleSpeed);

                var gradient = ctx.createLinearGradient(parent.width / 2, parent.height / 2, needleTipX, needleTipY);
                gradient.addColorStop(0, "white");
                gradient.addColorStop(1, "red");

                ctx.beginPath();
                ctx.moveTo(parent.width / 2, parent.height / 2);
                ctx.lineTo( needleTipX, needleTipY);
                ctx.lineWidth = needleWidth;
                ctx.lineCap = "round";
                ctx.strokeStyle = gradient;
                ctx.stroke();
            }
        }
    }
    function requestPrintFillCanvas()
    {
        canvasLeftFIll.requestPaint();
        canvasNeedleLeft.requestPaint();
    }
}
