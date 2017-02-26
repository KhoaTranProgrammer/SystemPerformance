import QtQuick 2.0
import "Global.js" as Data

Item {
    id: id_root

    signal clicked
    property string text
    property bool isRun: true

    Rectangle {
        id: id_bg

        anchors.fill: parent
        radius: height / 10
        color: isRun ? Data.component_bg_color_click : Data.component_bg_color

        MouseArea {
            anchors.fill: id_bg
            onClicked: {
                id_root.clicked()
            }
        }

        Text {
            anchors.centerIn: id_bg
            text: id_root.text
            color: Data.component_tx_color
            font.pixelSize: (id_bg.width + id_bg.height) / 4
            font.family: "Impact"
        }
    }
}
