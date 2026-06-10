import QtQuick
import quickshell
import quickshell.Wayland

ShellWindow {
    anchors.top: true
    anchors.right: true
    width: 300
    height: 100
    anchors.topMargin: 50 
    anchors.rightMargin: 20

    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.namespace: "quickshell-notifications"

    Rectangle {
        anchors.fill: parent
        color: "#181825"
        radius: 8
        border.color: "#fab387"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: "NOTIFICATION"
            color: "#fab387"
            font.bold: true
        }
    }
}
