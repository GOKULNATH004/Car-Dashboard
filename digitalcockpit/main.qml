import QtQuick 2.12
import QtQuick.Window 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick 2.0
import QtQuick.Controls 2.5

Window {
    width:1280
    height: 720
    visible: true
    title: qsTr("DIGITAL COCKPIT")

    Rectangle {
        id:bottomBar
        anchors {
            left:parent.left
            right:parent.right
            bottom:parent.bottom
        }
        color:"black"
        height:parent.height / 12
        Image {
            id: carSettingIcon
            anchors{
                left:parent.left
                leftMargin:520
                verticalCenter:parent.verticalCenter
            }
            height:parent.height * .95
            fillMode: Image.PreserveAspectFit
            source:"qrc:/../UI/ASSET/mmuussiicc.png"
            MouseArea{
                anchors.fill:parent
                onClicked:Qt.openUrlExternally("https://open.spotify.com/")
            }
        }
        Image {
            id: musicIcon
            anchors{
                left:parent.left
                leftMargin:30
                verticalCenter:parent.verticalCenter
            }
            height:parent.height * .95
            fillMode: Image.PreserveAspectFit
            source:"qrc:/../UI/ASSET/carlock.jpg"
            MouseArea{
                anchors.fill:parent
                onClicked:Qt.openUrlExternally("https://www.tesla.com/models")
            }
        }
        Image {
            id: whatsappIcon
            anchors{
                left:parent.left
                leftMargin:680
                verticalCenter:parent.verticalCenter
            }
            height:parent.height * .95
            fillMode: Image.PreserveAspectFit
            source:"qrc:/../UI/ASSET/pngwing.com.png"
            MouseArea{
                anchors.fill:parent
                onClicked:Qt.openUrlExternally("https://web.whatsapp.com/")
            }
        }
        Image {
            id: serviceicon
            anchors{
                left:parent.left
                leftMargin:600
                verticalCenter:parent.verticalCenter
            }
            height:parent.height * .95
            fillMode: Image.PreserveAspectFit
            source:"qrc:/../UI/ASSET/service.png"
            MouseArea{
                anchors.fill:parent
                onClicked:Qt.openUrlExternally("https://www.tesla.com/service")
            }
        }
        Image {
            id: youtubeicon
            anchors{
                left:parent.left
                leftMargin:760
                verticalCenter:parent.verticalCenter
            }
            height:parent.height * .95
            fillMode: Image.PreserveAspectFit
            source:"qrc:/../UI/ASSET/youtube.png"
            MouseArea{
                anchors.fill:parent
                onClicked:Qt.openUrlExternally("https://www.youtube.com/")
            }
        }
        HVACComponent{
            id:passengerHVACControl
            anchors{

                top:parent.top
                bottom:parent.bottom
                right:parent.right
                rightMargin: 150
            }
            hvacController: passengerHVAC
        }

    }
    Rectangle {
        id:rightscreen
        anchors{
            top:parent.top
            bottom:bottomBar.top
            right:parent.right
        }
         Plugin {
             id:mapPlugin
             name:"osm"
         }
         Map {
             anchors.fill:parent
             plugin:mapPlugin
             center:QtPositioning.coordinate(20.5937, 78.9629) //India
             zoomLevel:14
         }
         Image {
             id:lockIcon
             anchors{
                 left:parent.left
                 top:parent.top
                 margins:20

             }
             width:parent.width / 30
             fillMode: Image.PreserveAspectFit
                  source:(systemHandler.carlock ? ":/../UI/ASSET/carlock.jpg" : ":/../UI/ASSET/unlock_icon.png")
                 MouseArea{
                     anchors.fill:parent
                     onClicked:systemHandler.setCarLocked(!systemHandler.carLocked )
                 }


         }
         Rectangle{
             id:navSearchBox
             radius: 5
             color: "white"
             width: parent.width*1/3
             height: parent.height*1/12
             anchors{
                 left: lockIcon.left
                 top:lockIcon.bottom
                 topMargin: 15
             }
             Image {
                 id: searchIcon
                 anchors{
                     left: parent.left
                     leftMargin: 25
                     verticalCenter:parent.verticalCenter

                 }
                 height:parent.height *.45
                 fillMode: Image.PreserveAspectFit
                 source: "qrc:/../UI/ASSET/search.jpg"

             }
             Text {
                 id: navigationPlaceHolderText
                 color: "#373737"
                 text: qsTr("Navigate")
                 anchors{
                     verticalCenter: parent.verticalCenter
                     left: searchIcon.right
                     leftMargin: 20

                 }
             }
             TextInput{
                 id: navigationTextInput
                 anchors{
                     top:parent.top
                     bottom: parent.bottom
                     right: parent.right
                     left: searchIcon.right
                     leftMargin: 20
                 }
                 verticalAlignment: Text.AlignVCenter
                 font.pixelSize: 16
             }
         }
         Text{
             id:dateTimeDisplay
             anchors{
                 left:lockIcon.right
                 leftMargin:40
                 bottom:lockIcon.bottom
             }
             font.pixelSize: 12
             font.bold:true
             color:"black"
             text:"05:28:18"
         }

        width:parent.width * 2/3  }
    Rectangle {
        id:leftScreen
        anchors {
            left:parent.left
            right:rightscreen.left
            bottom:bottomBar.top
            top:parent.top
        }
        color:"white"

        Image {
            id: carRender
            anchors.centerIn: parent
            width: parent.width * .75
            fillMode: Image.PreserveAspectFit
            source: "qrc:/../UI/ASSET/red.jpg"

        }
    }

    }


