import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.UPower

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    Text {
        text: "hyprland"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        font.pointSize: 10
        font.family: "Inter"
        color: "#e0def4"
        anchors.leftMargin: 16
    }

    Rectangle {
        anchors.right: time.left
        anchors.verticalCenter: parent.verticalCenter
        color: hoverHandler.hovered ? "#6a6a86" : "#00000000"
        implicitHeight: battery.implicitHeight + 4
        implicitWidth: battery.implicitWidth + 8
        radius: 4
        anchors.rightMargin: 4

        HoverHandler {
            id: hoverHandler
            cursorShape: Qt.PointingHandCursor
        }

        Text {
            id: battery
            anchors.centerIn: parent
            text: (UPower.displayDevice.percentage) * 100 + "%"
            font.pointSize: 10
            font.family: "Inter"
            color: "#e0def4"
        }
    }

    ClockWidget {
        id: time
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 16
    }
    color: "#191724"
}
