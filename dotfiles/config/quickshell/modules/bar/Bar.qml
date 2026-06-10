import QtQuick
import quickshell
import quickshell.Wayland

ShellWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    height: 40

    WlrLayershell.layer: WlrLayershell.Top
    WlrLayershell.namespace: "quickshell-bar"

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        border.color: "#89b4fa"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: "BAR"
            color: "#89b4fa"
            font.bold: true
        }
    }
}
