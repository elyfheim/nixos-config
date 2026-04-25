import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts

import QtQuick.Controls
import Quickshell.Services.UPower
import Quickshell.Hyprland
import Quickshell.Wayland

Scope {
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
