import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io

PanelWindow {
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
        color: "#1C1C1E"
        radius: 10
        border.color: monitorState.text().trim() === "false" ? "#007AFF" : "#2C2C2E"
        border.width: 3
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
                    color: modelData.focused ? "#007AFF" : "#2C2C2E"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}