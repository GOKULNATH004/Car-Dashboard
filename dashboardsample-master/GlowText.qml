import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
    id: item
    property int x
    property int y
    property string text
    property string color
    property int pixelSize

    Rectangle {
        color: Qt.lighter(item.color, 3.0)
        radius: 10
        border.color: "blue"
        border.width: 2
        anchors.fill: parent

        Text {
            id: text
            text: item.text
            color: item.color
            font.pixelSize: item.pixelSize
            font.family: "helvetica"
            anchors.centerIn: parent
            anchors.fill: parent
        }

        Glow {
            anchors.fill: text
            radius: 3
            samples: 17
            color: Qt.lighter(item.color, 1.0)
            source: text
        }
    }
}
