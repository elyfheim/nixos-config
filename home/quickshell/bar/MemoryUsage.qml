import Quickshell
import QtQuick

Rectangle {
    id: root

    property bool showPopup: false
    color: showPopup ? "#6a6a86" : "#00000000"
    width: 60
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
        id: memory
        anchors.centerIn: parent
        text: `\uefc5   ${SystemInfo.memoryUsagePercentage}`
                color: "#c4a7e7" 
    font.pointSize: 10
    font.weight: Font.Medium
    font.family: "Inter"
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
            color: "#F0191724"
            implicitWidth: memorytext.width + 24
            implicitHeight: memorytext.height + 12
            radius: 6

            Text {
                id: memorytext
                anchors.centerIn: parent
                text: `Memory Usage: ${SystemInfo.memoryUsageDetail}`
                font.pointSize: 10
                font.family: "Inter"
                font.weight: Font.Medium
                color: "#c4a7e7" 
            }
        }
    }
}
