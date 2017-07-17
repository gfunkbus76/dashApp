import QtQuick 2.9
import QtGraphicalEffects 1.0

Canvas {
    id: canvas

    property int value : 0

     //130 minrotation, -30 maxrotation
    onValueChanged: {zeiger.rotation = Math.min(Math.max(-250, canvas.value*3.5 - 149), 0); canvas.currentValue = zeiger.rotation - 211}
    width: parent.width; height: parent.height

    Rectangle {
        id: zeiger
        rotation: -150 //see minrotation
        width: 4
        height: parent.width / 2
        transformOrigin: Item.Bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter

        smooth: true
        antialiasing: true
        color: "#81FFFE"
        onRotationChanged: {canvas.currentValue = zeiger.rotation - 211; canvas.requestPaint()}//texti.text = zeiger.rotation

            Behavior on rotation {
                NumberAnimation{
                    duration: 15000
                    easing.type: Easing.OutCirc
                }
            }
    }


      antialiasing: true

      property color secondaryColor: zeiger.color

      property real centerWidth: width / 2
      property real centerHeight: height / 2
      property real radius: Math.min(canvas.width, canvas.height) / 2

      property real minimumValue: -360
      property real maximumValue: 0
      property real currentValue: -360

      // this is the angle that splits the circle in two arcs
      // first arc is drawn from 0 radians to angle radians
      // second arc is angle radians to 2*PI radians
      property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI + 0.01
      property real angleOffset: 20.955 //to start at 0mph //-Math.PI / 2


      onPaint: {
          var ctx = getContext("2d");
          ctx.save();

          var gradient2 = ctx.createRadialGradient((parent.width / 2),(parent.height / 2), 0, (parent.width / 2),(parent.height / 2),parent.height);
           gradient2.addColorStop(0.5, "#81FFFE");   //up
          gradient2.addColorStop(0.46, "#81FFFE");   //up
          gradient2.addColorStop(0.45, "#112478");   //center
          gradient2.addColorStop(0.33, "transparent");   //below

          ctx.clearRect(0, 0, canvas.width, canvas.height);

          ctx.beginPath();
          ctx.lineWidth = 150;
          ctx.strokeStyle = gradient2
          ctx.arc(canvas.centerWidth, canvas.centerHeight, canvas.radius - (ctx.lineWidth / 2), canvas.angleOffset, canvas.angleOffset + canvas.angle);
          ctx.stroke();

          ctx.restore();
      }
}

