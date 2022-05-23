import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: root
    width: parent.width
    height:400

    Button{
        id: chooseButton
        Layout.fillWidth: true

        onClicked: fileDialog.open()
        text: "Choose a directory"
    }

    FolderDialog {
        id: fileDialog

        title: "Choose a folder...";

        onAccepted: {
            window.fileChangedSignal(fileDialog.currentFolder)
            console.log("You chose: " + fileDialog.currentFolder)
        }
    }

    ListView {
        id: list
        model: myModel

        Layout.fillWidth: true
        Layout.fillHeight: true
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        clip:true

        delegate: Component {
            Item {
                id: item
                property string imagePath: imagePathRole
                width: root.width
                height: 100

                Rectangle{
                    anchors.fill: parent
                    height: 80
                    width: parent.width
                    anchors.margins: 10

                    TextEdit {
                        id: textEdit
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - image.width
                        text: textMetrics.elidedText
                    }
                    TextMetrics {
                        id: textMetrics
                        elide: Text.ElideRight
                        elideWidth: textEdit.width
                        text: item.imagePath
                    }
                    Image {
                        id: image
                        fillMode: Image.PreserveAspectFit
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        source : Qt.resolvedUrl("file:///" + imagePath)
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#a7a7a7"
                    anchors.bottom: parent.bottom;
                }
            }

        }
    }
}
