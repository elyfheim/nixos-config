import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import Quickshell.Services.UPower
import Quickshell.Hyprland

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 16
        spacing: 6
        Repeater {
            model: 6
            Rectangle {
                property bool isActive: Hyprland.focusedWorkspace?.id === index + 1

                width: 12
                height: 12
                radius: 6

                color: isActive ? "#9ccfd8" : "#524f67"
            }
        }
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
            text: Math.round(UPower.displayDevice.percentage * 100) + "%"
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
