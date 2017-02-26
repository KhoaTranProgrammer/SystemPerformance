import QtQuick 2.0
import SysInfoQML 1.0
import "Global.js" as Data

Item {
    id: id_root

    SysInfoQML {
        id: id_sysInfo
    }

    Timer {
       id: id_timer
       repeat: true
       interval: 1000
       running: true

       onTriggered: {
           id_sysInfo.update()
           id_mem_cur.value = id_sysInfo.memUsage * 100 / id_sysInfo.memTotal;
           id_mem_his.updateData(id_sysInfo.memUsage * 100 / id_sysInfo.memTotal);
           id_memUsage.text = "Mem usage: " + id_sysInfo.memUsage/1024 + " GB";
       }
    }

    Text {
        id: id_memTotal

        anchors {
            left: id_root.left
            top: id_root.top
        }

        text: "Mem total: " + id_sysInfo.memTotal/1024 + " GB"
        color: Data.component_tx_color
        font.pixelSize: (id_root.height) / 14
        font.family: "Impact"
    }

    Text {
        id: id_memUsage

        anchors {
            left: id_root.left
            top: id_memTotal.bottom
        }

        text: "Mem usage: " + id_sysInfo.memUsage/1024 + " GB"
        color: Data.component_tx_color
        font.pixelSize: (id_root.height) / 14
        font.family: "Impact"
    }

    CurrentPercentArea {
        id: id_mem_cur

        anchors {
            left: id_root.left
            bottom: id_root.bottom
            margins: id_root.height * 0.01
        }
        height: id_root.height * 0.8
        width: height
    }

    HistoryArea {
        id: id_mem_his

        anchors {
            left: id_mem_cur.right
            bottom: id_root.bottom
            right: id_root.right
            margins: id_root.height * 0.01
        }
        height: id_root.height * 0.8
    }
}

