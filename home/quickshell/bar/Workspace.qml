import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import Quickshell.Hyprland

RowLayout {
    id: "workspacelayout"
    property int currentWorkspace: 1
    spacing: 6
    Repeater {
        model: 6
        Rectangle {
            property bool isActive: currentWorkspace === index + 1

            width: 10
            height: 10
            radius: 5

            color: isActive ? "#88c0d0" : "#4c566a"
        }
    }

    IpcHandler {
        target: "workspace"

        function setWorkspace(v: int): void {
            workspacelayout.currentWorkspace = v;
        }
    }
}
