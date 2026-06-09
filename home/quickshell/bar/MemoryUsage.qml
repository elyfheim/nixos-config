import Quickshell
import QtQuick

Rectangle {
    id: root

    property bool showPopup: false
    color: showPopup ? "#4c566a" : "#00000000"
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
        id: memory
        anchors.centerIn: parent
        text: `${SystemInfo.memoryUsagePercentage}`
        color: "#8fbcbb"
        font.pointSize: 9
        font.weight: Font.Medium
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
            color: "#3b4252"
            implicitWidth: memorytext.width + 24
            implicitHeight: memorytext.height + 12
            radius: 6

            Text {
                id: memorytext
                anchors.centerIn: parent
                text: `Memory Usage: ${SystemInfo.memoryUsageDetail}`
                font.pointSize: 9
                font.weight: Font.Medium
                color: "#8fbcbb"
            }
        }
    }
}
