import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: topbar
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        RowLayout {
            Layout.alignment: Qt.AlignLeft
            Logo {}
            Workspace {}
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Battery {}
            ClockWidget {}
        }
    }

    color: "#F0191724"
}
