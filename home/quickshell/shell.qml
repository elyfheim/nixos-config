import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Services.UPower

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    Text {
        text: (UPower.displayDevice.percentage) * 100 + "%"
        anchors.right: time.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 10
        color: "#e0def4"
        anchors.rightMargin: 12
    }

    ClockWidget {
        id: time
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 12
    }
    color: "#E0191724"
    // Rectangle {
    //     width: parent.width
    //     height: 24
    //     color: "steelblue"
    // }
}
