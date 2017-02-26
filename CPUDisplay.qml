import QtQuick 2.0
import SysInfoQML 1.0

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
           id_cpu_cur.value = id_sysInfo.cpuUsage;
           id_cpu_his.updateData(id_sysInfo.cpuUsage);
       }
    }

    CurrentPercentArea {
        id: id_cpu_cur

        anchors {
            left: id_root.left
            bottom: id_root.bottom
            margins: id_root.height * 0.01
        }
        height: id_root.height * 0.8
        width: height
    }

    HistoryArea {
        id: id_cpu_his

        anchors {
            left: id_cpu_cur.right
            bottom: id_root.bottom
            right: id_root.right
            margins: id_root.height * 0.01
        }
        height: id_root.height * 0.8
    }
}
