import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
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
            spacing: 2
            MemoryUsage {}
            Battery {}
            Rectangle {
                Layout.preferredWidth: 4
            }
            ClockWidget {}
        }
    }

    color: "#2e3440"
}
