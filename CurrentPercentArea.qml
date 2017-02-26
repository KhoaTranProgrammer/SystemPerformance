import QtQuick 2.0
import "Global.js" as Data

Item {
    id: id_root

    property int value: 0

    onValueChanged: {
        id_canvas.requestPaint()
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

            text: "Usage"
            color: Data.component_tx_color
            font.pixelSize: (id_bg.height) / 14
            font.family: "Impact"
        }

        Canvas {
            id: id_canvas

            anchors.fill: id_bg
            contextType: "2d"
            antialiasing: true
            rotation: 270

            onPaint: {
                var context = id_canvas.getContext('2d');
                context.strokeStyle = Data.component_bg_color_click;

                context.lineWidth = id_canvas.height * 0.1;
                context.beginPath();
                context.arc(id_canvas.height / 2, id_canvas.height / 2, id_canvas.height / 2 * 0.85, 0, Math.PI * 2, false);
                context.stroke();

                context.strokeStyle = Data.component_tx_color;
                context.beginPath();
                context.arc(id_canvas.height / 2, id_canvas.height / 2, id_canvas.height / 2 * 0.85, 0, Math.PI * 2 * value / 100, false);
                context.stroke();
            }
        }

        Text {
            anchors.centerIn: id_bg
            text: id_root.value + "%"
            color: Data.component_tx_color
            font.pixelSize: id_bg.height * 0.1
            font.family: "Impact"
        }
    }
}
