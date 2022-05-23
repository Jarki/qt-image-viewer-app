import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: window

    width: 640
    height: 480
    visible: true
    title: qsTr("Image viewer")

    signal fileChangedSignal(string msg)

    MainForm {
        anchors.fill: parent
    }
}
