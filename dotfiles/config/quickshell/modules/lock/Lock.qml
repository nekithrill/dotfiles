import QtQuick
import quickshell
import quickshell.Wayland

ShellWindow {
    anchors.fill: parent // Fullscreen

    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.namespace: "quickshell-lock"

    Rectangle {
        anchors.fill: parent
        color: "#11111b" // Almost black screen

        Column {
            anchors.centerIn: parent
            spacing: 10
            
            Text {
                text: "LOCKSCREEN"
                color: "#f38ba8" // Red text for test
                font.pixelSize: 24
                font.bold: true
            }
            Text {
                text: "Enter password ..."
                color: "#a6adc8"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
