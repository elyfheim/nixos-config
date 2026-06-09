import QtQuick // for Text

Rectangle {
    id: root
    property var showPopup: false
    width: 30
    height: 30
    radius: 4

    color: showPopup ? "#6a6a86" : "#00000000"
    Text {
        id: logotext
        font.pointSize: 12
        anchors.centerIn: parent
        color: "#88c0d0"
        text: "\uf313"
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: root.showPopup = true
        onExited: root.showPopup = false
    }
}
