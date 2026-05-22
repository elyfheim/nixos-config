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

            width: 12
            height: 12
            radius: 6

            color: isActive ? "#9ccfd8" : "#524f67"
        }
    }

    IpcHandler {
        target: "workspace"

        function setWorkspace(v: int): void {
            workspacelayout.currentWorkspace = v;
        }
    }
}
