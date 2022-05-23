import QtQuick 2.0

Rectangle {
    id: root

    ListView {
        id: list
        width: root.width
        height: root.height
        model: myModel
        spacing: 2

        delegate: Component {
           Item {
               id: item
               property string imagePath: imagePathRole
               width: parent.width
               height: 40
               TextEdit {
                   id: textEdit
                   wrapMode: Text.NoWrap
                   readOnly: true
                   width: parent.width
                   text: imagePath
               }
           }
        }
    }
}
