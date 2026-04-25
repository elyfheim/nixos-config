import Quickshell // for PanelWindow
import QtQuick // for Text

import Quickshell.Services.UPower

Rectangle {
    id: root
    visible: UPower.displayDevice.isLaptopBattery

    property bool showPopup: false
    color: showPopup ? "#6a6a86" : "#00000000"
    width: 30
    height: 30
    radius: 4

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: root.showPopup = true
        onExited: root.showPopup = false
    }

    Text {
        id: battery
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 1
        property var batteryInfo: {
            const percentage = Math.round(UPower.displayDevice.percentage * 100);
            if (percentage < 25) {
                return {
                    icon: "\uf244",
                    color: "#eb6f92"
                };
            } else if (percentage < 50) {
                return {
                    icon: "\uf243",
                    color: "#f6c177"
                };
            } else if (percentage < 75) {
                return {
                    icon: "\uf242",
                    color: "#9ccfd8"
                };
            } else {
                return {
                    icon: "\uf240",
                    color: "#9ccfd8"
                };
            }
        }
        text: batteryInfo.icon
        font.pointSize: 14
        font.family: "Inter"
        color: batteryInfo.color
    }

    PopupWindow {
        anchor.item: root
        anchor.rect.y: root.y + 34
        visible: root.showPopup
        color: "#00000000"
        implicitWidth: rect.width
        implicitHeight: rect.height

        Rectangle {
            id: rect
            property var percentage: Math.round(UPower.displayDevice.percentage * 100)
            color: "#F0191724"
            implicitWidth: batterytext.width + 24
            implicitHeight: batterytext.height + 12
            radius: 6

            Text {
                id: batterytext
                anchors.centerIn: parent
                text: `Battery${!UPower.onBattery ? " (charging)" : ""}: ${rect.percentage}%`
                font.pointSize: 10
                font.family: "Inter"
                font.weight: Font.Medium
                color: !UPower.onBattery ? rect.percentage === 100 ? "#9ccfd8" : "#f6c177" : "#e0def4"
            }
        }
    }
}
