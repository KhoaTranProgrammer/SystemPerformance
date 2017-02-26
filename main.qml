import QtQuick 2.6
import QtQuick.Window 2.2

Item {
    id: id_root
    anchors.fill: parent

    Component.onCompleted: {
        id_functionLoader.source = "CPUDisplay.qml"
        var scene = null
        scene = id_functionLoader.item
        scene.parent = id_root
        scene.anchors.fill = id_bottom
    }

    Rectangle {
        anchors.fill: parent
        color: "#283593"
    }

    ButtonArea {
        id: id_bt_cpu

        anchors {
            left: id_root.left
            top: id_root.top
            margins: id_root.height * 0.01
        }

        width: id_root.width * 0.12
        height: id_root.height * 0.08
        text: "CPU"

        onClicked: {
            if(!isRun){
                isRun = !isRun;
                id_bt_ram.isRun = !id_bt_ram.isRun;
                id_functionLoader.source = "CPUDisplay.qml"
                var scene = null
                scene = id_functionLoader.item
                scene.parent = id_root
                scene.anchors.fill = id_bottom
            }
        }
    }

    ButtonArea {
        id: id_bt_ram

        anchors {
            left: id_bt_cpu.right
            top: id_root.top
            margins: id_root.height * 0.01
        }

        width: id_root.width * 0.12
        height: id_root.height * 0.08
        isRun: false
        text: "RAM"

        onClicked: {
            if(!isRun){
                isRun = !isRun;
                id_bt_cpu.isRun = !id_bt_cpu.isRun;
                id_functionLoader.source = "MEMDisplay.qml"
                var scene = null
                scene = id_functionLoader.item
                scene.parent = id_root
                scene.anchors.fill = id_bottom
            }
        }
    }

    Rectangle {
        id: id_bottom
        color: "transparent"
        anchors {
            left: id_root.left
            right: id_root.right
            bottom: id_root.bottom
            top: id_bt_cpu.bottom
            margins: id_root.height * 0.01
        }
        height: id_root.height * 9 / 10
    }

    Loader {
        id: id_functionLoader
    }
}
