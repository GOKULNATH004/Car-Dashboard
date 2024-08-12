import QtQuick 2.0

Item {
    property string fontColor: "f0eded"
    property var hvacController
    Rectangle{
        id:decrementButton
        anchors{
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: height/2
        color: "black"
        Text{
            id:decrementText
            anchors.centerIn: parent
            text: "<"
            font.pixelSize: 15
            color: "white"
        }
        MouseArea{
            anchors.fill:parent
            onClicked: hvacController.incrementTargetTemperature(-1)
        }

        }
    Text {
     id: targetTemperatureText
      anchors{
      left: decrementButton.right
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
    color: "white"
    font.pixelSize: 24
    text: "70"
}
Rectangle{
    id:incrementButton
    anchors{
        left: targetTemperatureText.right
        top: parent.top
        bottom: parent.bottom
        leftMargin: 15
    }
    width: height/2
    color: "black"
    Text{
        id:incrementText
        color:"white"
        anchors.centerIn: parent
        text:">"
        font.pixelSize: 15

    }
    MouseArea{
        anchors.fill:parent
        onClicked: hvacController.incrementTargetTemperature(1)
    }
    }
}
