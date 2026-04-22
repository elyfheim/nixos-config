import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts

import QtQuick.Controls
import Quickshell.Services.UPower
import Quickshell.Hyprland
import Quickshell.Wayland

ShellRoot {
    PanelWindow {
        id: toplevel
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
            id: batterysection

            property bool showPopup: false
            anchors.right: time.left
            anchors.verticalCenter: parent.verticalCenter
            color: showPopup ? "#6a6a86" : "#00000000"
            implicitHeight: battery.implicitHeight + 4
            implicitWidth: battery.implicitWidth + 8
            radius: 4
            anchors.rightMargin: 6

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: () => {
                    batterysection.showPopup = !batterysection.showPopup;
                }
                onEntered: batterysection.showPopup = true
                onExited: batterysection.showPopup = false
            }

            Text {
                id: battery
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
                anchors.centerIn: parent
                font.pointSize: 14
                font.family: "Inter"
                color: batteryInfo.color
            }

            PopupWindow {
                anchor.window: toplevel
                anchor.rect.x: batterysection.x
                anchor.rect.y: anchor.window.height + 4
                visible: batterysection.showPopup
                mask: Region {
                    item: rect
                }
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

        ClockWidget {
            id: time
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 16
        }
        color: "#F0191724"
    }

    PanelWindow {
        id: applauncher
        visible: false
        focusable: true
        color: "transparent"
        property int currentIndex: 0

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        MouseArea {
            anchors.fill: parent
            onClicked: applauncher.visible = false
        }

        Rectangle {
            id: launchercontainer
            anchors.centerIn: parent
            width: 600
            height: 400
            border.color: "#524f67"
            border.width: 2
            radius: 10
            Keys.onEscapePressed: applauncher.visible = false
            Keys.onDownPressed: {
                if (applauncher.currentIndex < appLists.values.length - 1)
                    applauncher.currentIndex = applauncher.currentIndex + 1;
            }
            Keys.onUpPressed: {
                if (applauncher.currentIndex > 0)
                    applauncher.currentIndex = applauncher.currentIndex - 1;
            }
            Keys.onReturnPressed: {
                applauncher.visible = false;
                appLists.values[applauncher.currentIndex].execute();
            }
            color: "#F0191724"

            Rectangle {
                id: inputwrapper
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                anchors.top: parent.top
                anchors.topMargin: 12
                radius: 10
                color: "#524f67"
                border.color: "#524f67"
                border.width: 2
                width: parent.width - 24

                height: 60
                TextInput {
                    id: input
                    anchors.centerIn: parent
                    width: parent.width - 40
                    focus: true
                    clip: true
                    font.pointSize: 21
                    font.family: "Inter"
                    font.weight: Font.Medium
                    color: "#e0def4"

                    onTextChanged: applauncher.currentIndex = 0
                }
            }
            ScriptModel {
                id: appLists
                objectProp: "id"
                values: {
                    let curList = [...DesktopEntries.applications.values];
                    curList = curList.filter(({
                            name
                        }) => (name.toLowerCase().includes(input.text.trim().toLowerCase())));
                    curList.sort((a, b) => a.name.toLowerCase().localeCompare(b.name.toLowerCase()));
                    return curList;
                }
            }

            ListView {
                anchors.top: inputwrapper.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 12
                height: 300
                width: parent.width - 24
                clip: true
                model: appLists
                currentIndex: applauncher.currentIndex

                delegate: Rectangle {
                    required property var modelData
                    required property int index

                    width: parent.width
                    height: 50
                    radius: 6

                    color: applauncher.currentIndex === index ? "#6a6a86" : "transparent"

                    MouseArea {
                        id: apphover
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: () => {
                            applauncher.visible = false;
                            modelData.execute();
                        }
                        onEntered: applauncher.currentIndex = index
                    }

                    Text {
                        anchors.centerIn: parent
                        width: parent.width - 24
                        font.pointSize: 16
                        font.family: "Inter"
                        font.weight: Font.Medium
                        color: "#e0def4"
                        text: modelData.name
                    }
                }
            }
        }
    }

    GlobalShortcut {
        appid: "quickshell"
        name: "app_launcher"

        onPressed: () => {
            applauncher.visible = !applauncher.visible;
            if (applauncher.visible) {
                input.text = "";
                input.forceActiveFocus();
            }
        }
    }
}
