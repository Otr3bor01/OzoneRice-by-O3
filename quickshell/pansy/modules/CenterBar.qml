import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Mpris

PanelWindow {
    //===Basics
    id: root
    screen: Quickshell.screens.find(s => s.name === "DP-1")
    anchors{
        bottom: false;
        left: true;
        top: true;
        right: true;
    }
    margins{
        left: 10;
        top: 10;
        right: 10;
    }
    implicitHeight: 35
    color: "transparent"
    //===FileView for the workspace system
    FileView {
        id: monitorState
        path: "/tmp/hypr_secondMonitor"
        watchChanges: true
        onFileChanged: reload()
    }

    //===Mpris
    //Crying so loud rn, help

    //===Row
    Row{
        anchors.fill: parent
        spacing: 10
        //workspace indicator
        Rectangle {
            id: workspaceIndicator
            implicitWidth: 290
            implicitHeight: 35
            color: Qt.rgba(18/255, 13/255, 30/255, 0.5)
            radius: 100
            border.color: monitorState.text().trim() === "false" ? "#D9D0E8" : "#443355"
            border.width: 1.5
            Row {
                anchors.fill: parent
                anchors.centerIn: parent
                spacing: 6
                padding: 8
                Repeater {
                    model: Hyprland.workspaces.values.filter(ws => ws.id > 0 && ws.id <= 5)
                    delegate: Rectangle {
                        width: 50
                        height: 10
                        radius: 5
                        color: modelData.active 
                            ? "#443355" 
                            : Qt.rgba(18/255, 13/255, 30/255, 0.5)
                        border.color: modelData.active 
                            ? "#D9D0E8" 
                            : mouseArea.containsMouse 
                                ? Qt.rgba(0.85, 0.82, 0.91, 0.5)
                                : "#2C2C2E"
                        border.width: 2
                        anchors.verticalCenter: parent.verticalCenter
                        //on click change workspace
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Hyprland.dispatch("hl.dsp.focus({ workspace = " + modelData.id + " })")
                            }
                        }
                    }
                }
            }
        }
        //spacer 
        Rectangle {
            width: 100
            height: 100
            color: "transparent"
        }
        //Center Bar
        Rectangle {
            implicitWidth: 1000
            implicitHeight: 35
            color: Qt.rgba(18/255, 13/255, 30/255, 0.5)
            radius: 100
            border.color: "#443355"
            border.width: 1.5
            //Center Bar Row
            Row {
                anchors.fill: parent
                anchors.centerIn: parent
                spacing: 6
                padding: 8
                //Theme Changer Interface (WIP)
                Text {
                    text: "Wip Theme :3"
                    color: "#D9D0E8"
                    font.pixelSize: 14
                }
                //Mpris Row
                Row {
                    spacing: 6
                    Text {
                        text: "Help"
                        color: "#D9D0E8"
                        font.pixelSize: 14
                    }

                    Text {
                        text: "Me"
                        color: "#D9D0E8"
                        font.pixelSize: 12
                    }
                }

            }

        }
    }
}
