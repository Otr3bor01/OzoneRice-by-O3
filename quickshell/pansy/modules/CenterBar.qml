import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import QtQuick.Layouts
import QtQuick.Effects

PanelWindow {
    //===Basics
    id: root
    screen: Quickshell.screens.find(s => s.name === "DP-1")
    aboveWindows: false
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


    //===Mpris property bind
    QtObject {
        id: internalState
        readonly property var cache: ({ player: null })
    }

    property var activePlayer: {
        var players = (Mpris && Mpris.players) ? Mpris.players.values : [];
        
        var playingPlayer = null;
        for (var j = 0; j < players.length; j++) {
            if (players[j].playbackState === MprisPlayer.Playing) {
                playingPlayer = players[j];
                break;
            }
        }

        if (playingPlayer) {
            internalState.cache.player = playingPlayer;
            return playingPlayer;
        }

        var cached = internalState.cache.player;
        var exists = false;
        for (var k = 0; k < players.length; k++) {
            if (players[k] === cached) {
                exists = true;
                break;
            }
        }

        return exists ? cached : (players.length > 0 ? players[0] : null);
    }

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
                            ?  "#C87DD4"
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
            RowLayout {
                id: centralBar
                anchors.fill: parent
                anchors.centerIn: parent
                spacing: 30
                //Theme Changer Interface (WIP)
                Item{
                    id: themeName
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 60
                    Layout.bottomMargin: 0
                    
                    RowLayout {
                        spacing: 5
                        anchors.centerIn: parent
                        Text {
                            color: "#C87DD4"
                            font.pixelSize: 18
                            font.bold: true
                            text: "✿"
                        }
                        Text {
                            text: "Pansy"
                            color: "#D9D0E8"
                            font.pixelSize: 18
                            font.bold: true
                            font.family: "Iosevka"
                        }
                        Text {
                            color: "#C87DD4"
                            font.pixelSize: 18
                            font.bold: true
                            text: "✿"
                        }
                    }
                }
                //Mpris Row  (WIP) 
                Item {
                    implicitWidth: 300
                    Layout.rightMargin: 200
                    Layout.leftMargin: 200
                    Layout.alignment: Qt.AlignHCenter
                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 6
                        Text {
                            text: ""
                            font.pixelSize: 16
                            color: "#C87DD4"
                            font.family: "JetBrainsMono Nerd Font"
                        }
                        Text { //artist
                            text: {
                                if (!activePlayer) return "No player";
                                
                                var artist = activePlayer.trackArtist ? activePlayer.trackArtist : "";
                                
                                return artist !== "" ? artist : artist
                            }
                            font.family: "Iosevka"
                            font.bold: true
                            font.pixelSize: 16
                            color: "#D9D0E8"

                            Layout.maximumWidth: 150
                            elide: Text.ElideRight 
                        }
                        Text {
                            text: " "
                        }
                        Text {
                            text: ""
                            font.pixelSize: 16
                            color: "#C87DD4"
                            font.family: "JetBrainsMono Nerd Font"
                        }
                        Text {
                            text: {
                                if (!activePlayer) return "";

                                var title = activePlayer.trackTitle ? activePlayer.trackTitle : "!Unknown!";

                                return title !== "!Unknown!" ? title : title
                            }
                            Layout.maximumWidth: 250 
                            elide: Text.ElideRight 
                            font.family: "Iosevka"
                            font.pixelSize: 16
                            color: "#D9D0E8"
                        }

                        Text { //spacer
                            text: "    "
                        }

                        
                        Text { //previous
                            text: "󰒮"
                            font.pixelSize: 30
                            color: previousMouse.containsMouse ? "#D9D0E8" : "#C87DD4"
                            
                            MouseArea {
                                id: previousMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: if (activePlayer && activePlayer.canGoPrevious) activePlayer.previous()
                            }
                        }
                        Item { //cover and pause
                            Layout.preferredWidth: 25
                            Layout.preferredHeight: 25

                            Rectangle { //fallback
                                anchors.fill: parent
                                color: "#D9D0E8"
                                radius: parent.width/2
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "󰎇"
                                    visible: parent.parent.children[2].status !== Image.Ready
                                    color: "#443355"
                                    font.bold: true
                                    font.pixelSize: 20
                                }
                            }

                            Rectangle { //mask
                                id: mask
                                anchors.fill: parent
                                radius: parent.width/2
                                visible: false 
                                layer.enabled: true 
                            }

                            Rectangle { //border
                                id: bordino
                                anchors.centerIn: mask
                                radius: bordino.width/2
                                width: 28
                                height: 28
                                color: "transparent"
                                border.color: "#C87DD4"
                                z: 1
                                border.width: 2

                                antialiasing: true
                            }
                            Text { //pause
                                anchors.centerIn: mask
                                text: activePlayer && activePlayer.playbackState === MprisPlayer.Playing ? "" : ""
                                color: playMouse.containsMouse ? "#D9D0E8" : "#C87DD4"
                                MouseArea {
                                    id: playMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: if (activePlayer) activePlayer.togglePlaying()
                                }
                                font.bold: true
                                font.pixelSize: 15
                                z: 1
                            }
                            Image {
                                id: coverImage
                                anchors.fill: parent
                                
                                source: {
                                    if (!activePlayer) return "";
                                    var url = "";
                                    if (activePlayer.artUrl) url = activePlayer.artUrl.toString();
                                    if (url === "" && activePlayer.metadata && activePlayer.metadata["mpris:artUrl"]) {
                                        url = activePlayer.metadata["mpris:artUrl"].toString();
                                    }
                                    if (url === "") return "";
                                    if (url.startsWith("/")) return "file://" + url;
                                    return url;
                                }
                                
                                fillMode: Image.PreserveAspectCrop
                                
                                layer.enabled: true
                                layer.effect: MultiEffect {
                                    maskEnabled: true
                                    maskSource: mask
                                }
                            }
                        }

                        Text {
                            text: "󰒭"
                            font.pixelSize: 30
                            color: nextMouse.containsMouse ? "#D9D0E8" : "#C87DD4"

                            MouseArea {
                                id: nextMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: if (activePlayer && activePlayer.canGoNext) activePlayer.next()
                            }
                        }
                    }
                }
                //Time and Date (WIP)
                Item{
                    id: dateTime
                    property var currentTime: new Date()
                    Layout.alignment: Qt.AlignVCenter
                    Layout.rightMargin: 100
                    Layout.bottomMargin: 0
                    Timer{
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: parent.currentTime = new Date()
                    }
                    
                    RowLayout{
                        anchors.centerIn: parent
                        spacing: 2
                        Text{
                            text: ""
                            color: "#C87DD4"
                            font.pixelSize: 18
                            font.bold: true
                        }
                        Text{
                            text: Qt.formatDateTime(dateTime.currentTime, "hh:mm") 
                            color: "#D9D0E8"
                            font.pixelSize: 16
                            font.bold: true
                            font.family: "Iosevka"
                        }
                        Text{
                            text:"      "
                        }
                        Text{
                            text: ""
                            color: "#C87DD4"
                            font.pixelSize: 18
                            font.bold: true
                        }
                        Text{
                            text: Qt.formatDateTime(dateTime.currentTime, "dd/MM/yyyy") 
                            color: "#D9D0E8"
                            font.pixelSize: 16
                            font.bold: true
                            font.family: "Iosevka"
                        }
                    }

                    
                }

            }
        }
    }
}
