import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: root
    width: parent.width
    height:400
    signal imageOpened(string _imagePath);

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
        }
    }

    GridView{
        id:grid
        model: myModel

        visible: false
        Layout.fillWidth: true
        Layout.fillHeight: true
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        cellWidth: root.width / 4
        cellHeight: 100
        clip: true

        delegate: Component {
            Item {
                id: item

                width: grid.cellWidth; height: grid.cellHeight
                property string imagePath: imagePathRole

                Rectangle{
                    anchors.fill: item
                    anchors.margins: 10

                    Image {
                        id: image
                        fillMode: Image.PreserveAspectFit

                        width: parent.width
                        height: parent.height - textEdit.height
                        source : Qt.resolvedUrl("file:///" + imagePath)
                    }
                    TextEdit {
                        id: textEdit

                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        width: parent.width
                        text: textMetrics.elidedText
                    }
                    TextMetrics {
                        id: textMetrics
                        elide: Text.ElideRight
                        elideWidth: textEdit.width
                        text: item.imagePath
                    }
                }
                // borders
                // bottom
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#a7a7a7"
                    anchors.bottom: parent.bottom;
                }
                // top
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#a7a7a7"
                    anchors.top: parent.top;
                }
                // right
                Rectangle {
                    width: 1
                    height: parent.width
                    color: "#a7a7a7"
                    anchors.right: parent.right;
                }
                // left
                Rectangle {
                    width: 1
                    height: parent.width
                    color: "#a7a7a7"
                    anchors.left: parent.left;
                }
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        root.imageOpened(imagePath)
                    }
                }
            }
        }
    }

    PathView {
        id: path
        model: myModel

        visible: true
        Layout.fillWidth: true
        Layout.fillHeight: true

        pathItemCount: 3
        path: Path {
            startX: 0; startY: parent.height / 2
            PathLine { x: parent.width; y: parent.height/2 }
        }

        preferredHighlightBegin: 0.5                         //
        preferredHighlightEnd: 0.5                           // That should center the current item
        highlightRangeMode: PathView.StrictlyEnforceRange
        clip: true

        delegate: Component {
            Column{
                property string imagePath: imagePathRole

                opacity: PathView.isCurrentItem ? 1 : 0.5
                Image {
                    id: image
                    fillMode: Image.PreserveAspectFit

                    width: root.width / 3
                    source : Qt.resolvedUrl("file:///" + imagePath)

                                        MouseArea{
                                            anchors.fill: parent

                                            onClicked: {
                                                root.imageOpened(imagePath)
                                            }
                                        }
                }
                                TextEdit {
                                    id: textEdit

                                    width: image.width
                                    text: textMetrics.elidedText
                                }
                                TextMetrics {
                                    id: textMetrics
                                    elide: Text.ElideRight
                                    elideWidth: textEdit.width
                                    text: imagePath
                                }
            }
        }
    }

    ListView {
        id: list
        model: myModel

        visible: false
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
                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        root.imageOpened(imagePath)
                    }
                }
            }
        }
    }
    Rectangle{
        id:imageWrapper
        visible: false

        width: parent.width
        height: parent.height

        Image{
            id: imageView

            height: parent.height
            fillMode: Image.PreserveAspectFit
            // this centers
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            // this does not
            // anchors.centerIn: parent.Center
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                imageWrapper.visible = false
            }
        }

        Connections{
            target: root
            function onImageOpened(_imagePath){
                imageView.source = Qt.resolvedUrl("file:///" + _imagePath)
                imageWrapper.visible = true
            }
        }
    }
}


