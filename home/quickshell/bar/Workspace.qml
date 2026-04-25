import QtQuick
import QtQuick.Layouts

import Quickshell.Hyprland

RowLayout {
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
