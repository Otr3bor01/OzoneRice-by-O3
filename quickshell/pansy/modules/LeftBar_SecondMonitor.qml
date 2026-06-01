import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    screen: Quickshell.screens.find(s => s.name === "DP-2")
    anchors {
        bottom: false;
        left: true;
        top: true;
    }
    
    width: 300
    implicitHeight: 35
    color: "transparent"

    margins{
        left: 10;
        top: 10;
    }

    FileView {
        id: monitorState
        path: "/tmp/hypr_secondMonitor"
        watchChanges: true
        onFileChanged: reload()
}

    //Hyprland workspace (Am I doing everything wrong?)
    Rectangle { 
        anchors.fill: parent
        color: Qt.rgba(18/255, 13/255, 30/255, 0.5)
        radius: 10
        border.color: monitorState.text().trim() === "true" ? "#D9D0E8" : "#443355"
        border.width: 2
        Row {
            anchors.fill: parent
            anchors.centerIn: parent
            spacing: 6
            padding: 8
            Repeater {
                model: Hyprland.workspaces.values.filter(ws => ws.id > 5 && ws.id <= 10)
                delegate: Rectangle {
                    width: 50
                    height: 10
                    radius: 5
                    color: modelData.focused ? "#443355" : Qt.rgba(18/255, 13/255, 30/255, 0.5)
                    border.color: modelData.focused ? "#D9D0E8" : "#2C2C2E"
                    border.width: 2
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}