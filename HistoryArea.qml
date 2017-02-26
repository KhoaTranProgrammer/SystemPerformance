import QtQuick 2.0
import "Global.js" as Data

Item {
    id: id_root

    property int duration: 60

    function updateData(newData) {
        if(id_drawPos.dataIndex > id_root.duration){
            id_drawPos.dataIndex = 0;
        }
        id_drawPos.data[id_drawPos.dataIndex++] = newData;
        id_canvas.requestPaint();
    }

    QtObject {
        id: id_drawPos
        property int left : id_root.width * 0.02
        property int top : id_root.height * 0.15
        property int right : id_root.width * 0.89
        property int bottom : id_root.height * 0.9

        property int stepHeight : (id_drawPos.bottom - id_drawPos.top) / 10
        property int stepWidth : (id_drawPos.right - id_drawPos.left) / (id_root.duration)

        property var data: []
        property int dataIndex: 0
    }

    Rectangle {
        id: id_bg

        anchors.fill: id_root
        color: Data.component_bg_color

        Text {
            anchors {
                left: id_bg.left
                top: id_bg.top
                margins: id_bg.height * 0.008
            }

            text: "History"
            color: Data.component_tx_color
            font.pixelSize: (id_bg.height) / 14
            font.family: "Impact"
        }

        Canvas {
            id: id_canvas

            anchors.fill: id_bg
            contextType: "2d"
            antialiasing: true

            onPaint: {
                var context = id_canvas.getContext('2d');
                context.clearRect(id_drawPos.left, id_drawPos.top, id_bg.width, id_bg.height)

                context.strokeStyle = Data.component_bg_color_click;
                context.lineWidth = id_canvas.height * 0.005;

                context.beginPath();
                context.moveTo(id_drawPos.left, id_drawPos.top);
                context.lineTo(id_drawPos.left, id_drawPos.bottom);
                context.moveTo(id_drawPos.right, id_drawPos.top);
                context.lineTo(id_drawPos.right, id_drawPos.bottom);
                for(var i = 0; i < 11; i++){
                    context.moveTo(id_drawPos.left, id_drawPos.top + id_drawPos.stepHeight * i + id_drawPos.stepHeight * 0.02);
                    context.lineTo(id_drawPos.right, id_drawPos.top + id_drawPos.stepHeight * i + id_drawPos.stepHeight * 0.02);
                    context.fillStyle = Data.component_tx_color;
                    context.font = id_canvas.height * 0.05 + "px sans-serif";
                    context.fillText("" + (100 - i * 10) + "%", id_drawPos.right + id_canvas.height * 0.01, id_drawPos.top + id_drawPos.stepHeight * i + id_drawPos.stepHeight * 0.25);
                }
                context.fillText("" + id_root.duration + "s", id_drawPos.left, id_drawPos.top + id_drawPos.stepHeight * 10 + id_canvas.height * 0.05);
                context.stroke()

                //draw data
                context.beginPath();
                context.strokeStyle = Data.component_tx_color;
                context.lineWidth = id_canvas.height * 0.0075;
                var drawIndex = id_drawPos.dataIndex % id_drawPos.data.length;
                var x, y;
                x = id_drawPos.right + id_drawPos.stepWidth - id_drawPos.stepWidth * (id_drawPos.data.length);
                y = id_drawPos.bottom - (id_drawPos.bottom - id_drawPos.top) * id_drawPos.data[drawIndex] / 100 - id_drawPos.stepHeight * 0.02;
                context.moveTo(x, y);
                for(var n = 0; n < id_drawPos.data.length; n++){
                    x = id_drawPos.right + id_drawPos.stepWidth - id_drawPos.stepWidth * (id_drawPos.data.length - n);
                    y = id_drawPos.bottom - (id_drawPos.bottom - id_drawPos.top) * id_drawPos.data[drawIndex] / 100 - id_drawPos.stepHeight * 0.02;
                    context.lineTo(x,y);
                    drawIndex = (drawIndex + 1) % id_drawPos.data.length;
                }

                context.stroke()
            }
        }
    }
}
